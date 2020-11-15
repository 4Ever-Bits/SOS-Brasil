import 'package:flutter/material.dart';

import 'package:loading_overlay/loading_overlay.dart';

import 'package:SOS_Brasil/components/snackbar.dart';

import 'package:SOS_Brasil/controllers/session_controller.dart';

import 'package:SOS_Brasil/screens/ForgotPasswordScreen/fp_insertcode.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email;
  bool _isLoading = false;

  _onSubmit() async {
    try {
      setState(() {
        _isLoading = true;
      });

      bool hasSentEmail = await SessionController.forgotPassword(_email);

      if (hasSentEmail) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => InsertPasswordCode(email: _email),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      CustomSnackbar.showAuthenticationError(context, "Email inexistente");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.white60,
      isLoading: _isLoading,
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  Container buildBody() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Esqueceu a senha?",
              style: TextStyle(fontSize: 24),
            ),
            Icon(Icons.vpn_key, size: 80, color: Colors.grey[600]),
            Text(
              "Insira seu email de cadastro.",
              style: TextStyle(fontSize: 21),
            ),
            Text(
              "Será enviado um código para este email para que você possa mudar sua senha.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.justify,
            ),
            buildTextField(),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Container buildButton() {
    return Container(
      width: 140,
      height: 50,
      child: FlatButton(
        child: Text(
          "Enviar",
          style: TextStyle(fontSize: 18),
        ),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: _onSubmit,
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: "Insira seu email",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }
}
