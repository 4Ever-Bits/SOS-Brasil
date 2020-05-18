import 'package:flutter/material.dart';
import 'package:mobile/components/top_box.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TopBox(
                title: "Cadastro",
              )
            ],
          ),
        ));
  }
}
