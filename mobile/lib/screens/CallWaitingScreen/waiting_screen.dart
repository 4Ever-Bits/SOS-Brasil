import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/components/snackbar.dart';

import 'package:mobile/models/call.dart';

import 'package:mobile/controllers/call_controller.dart';
import 'package:mobile/models/user.dart';

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

  @override
  void initState() {
    call = widget.call;

    sendData();

    super.initState();
  }

  sendData() {
    //Get user token in localStorage
    storage.read(key: "token").then((value) {
      setState(() {
        token = value;
      });

      //Send data to the server
      CallController.create(call, value, widget.url).then((value) {
        if (value) {
          setState(() {
            _status = "Solicitação enviada com sucesso";
          });
        } else {
          _status = "Houve um problema no envio do chamado";
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
