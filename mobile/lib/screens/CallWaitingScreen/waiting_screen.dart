import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:SOS_Brasil/components/snackbar.dart';

import 'package:SOS_Brasil/models/call.dart';

import 'package:SOS_Brasil/controllers/call_controller.dart';
import 'package:SOS_Brasil/models/user.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

final storage = new FlutterSecureStorage();

class WaitingScreen extends StatefulWidget {
  final Call call;
  final Color color;
  final String url;

  const WaitingScreen({Key key, this.call, this.color, this.url})
      : super(key: key);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Call call;
  String token;

  String _status = "Conectando ao servidor...";

  IO.Socket socket;

  @override
  void initState() {
    call = widget.call;

    sendData();

    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();

    super.dispose();
  }

  sendData() {
    //Get user token in localStorage
    storage.read(key: "token").then((value) {
      setState(() {
        token = value;
      });

      socket = IO.io("http://201.75.9.143:3002/user", <String, dynamic>{
        'transports': ['websocket'],
      });
      socket.connect();

      socket.on("connect", (_) {
        if (_status != "Solicitação enviada com sucesso" &&
            _status != "Tempo limite de conexão atingido" &&
            _status != "Erro ao conectar ao servidor") {
          setState(() {
            _status = "Enviando o chamado...";
          });
        }
      });

      socket.on("connect_error", (data) {
        setState(() {
          _status = "Erro ao conectar ao servidor";
        });
      });

      socket.on("connect_timeout", (data) {
        setState(() {
          _status = "Erro ao conectar ao servidor";
        });
      });

      socket.on("connecting", (_) => print("conectando"));

      // Send data to the server
      CallController.create(call, value, "http://201.75.9.143:3002")
          .then((value) {
        if (value.isNotEmpty) {
          setState(() {
            _status = "Solicitação enviada com sucesso";
          });
          socket.emit("create_call", value);
        } else {
          _status = "Tempo limite de conexão atingido";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                _status,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: 270,
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      CustomSnackbar.showBuildInProgress(context);
                    },
                    child: Text(
                      "Acompanhar solicitação",
                      style: TextStyle(fontSize: 16),
                    ),
                    color: widget.color,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
