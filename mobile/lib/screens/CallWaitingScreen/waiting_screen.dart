import 'dart:convert';
import 'dart:io';

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

  String _status = "Enviando chamado";

  // IO.Socket socket;

  @override
  void initState() {
    call = widget.call;

    sendData();

    super.initState();
  }

  sendData() {
    //Get user token in localStorage
    storage.read(key: "token").then((value) async {
      setState(() {
        token = value;
      });

      IO.Socket socket =
          IO.io("http://201.75.9.143:3002/user", <String, dynamic>{
        'transports': ['websocket'],
      });
      socket.connect();

      socket.on("connect", (_) => print("connected"));

      socket.on("connect_error", (data) {
        print("error");
        print(data);
      });

      socket.on("connect_timeout", (data) {
        print("timeout");
        print(data);
      });

      socket.on("connecting", (_) => print("conectando"));

      String title = call.title;
      String description = call.description;
      bool isPersonal = call.isPersonal;
      double latitude = call.latitude;
      double longitude = call.longitude;
      int userId = call.userId;
      File imageFile = call.imageFile;
      File audioFile = call.audioFile;

      final imageByte =
          imageFile != null ? await imageFile.readAsBytes() : null;
      final audioByte =
          audioFile != null ? await audioFile.readAsBytes() : null;

      Map<String, dynamic> callJson = {
        "title": title,
        "description": description,
        "isPersonal": isPersonal.toString(),
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "user_id": userId.toString(),
        "audio_file": audioByte,
        "image_file": imageByte,
      };

      print(callJson);

      socket.emitWithBinary("create_call", callJson);

      //Send data to the server
      // CallController.create(call, value, widget.url).then((value) {
      //   if (value) {
      //     setState(() {
      //       _status = "Solicitação enviada com sucesso";
      //     });
      //   } else {
      //     _status = "Houve um problema no envio do chamado";
      //   }
      // });
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
