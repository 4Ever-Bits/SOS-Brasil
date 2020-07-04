import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/models/call.dart';

import 'package:mobile/controllers/call_controller.dart';
import 'package:mobile/models/user.dart';

final storage = new FlutterSecureStorage();

class WaitingScreen extends StatefulWidget {
  final Call call;
  final Color color;

  const WaitingScreen({Key key, this.call, this.color}) : super(key: key);

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

    print(call.userId);

    getStorageToken();

    CallController.create(call, token).then((value) {
      if (value) {
        setState(() {
          _status = "Solicitação enviada com sucesso";
        });
      } else {
        _status = "Houve um problema no envio do chamado";
      }
    });

    super.initState();
  }

  getStorageToken() {
    storage.read(key: "token").then((value) {
      print(value);
      setState(() {
        token = value;
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
                    onPressed: () {},
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
