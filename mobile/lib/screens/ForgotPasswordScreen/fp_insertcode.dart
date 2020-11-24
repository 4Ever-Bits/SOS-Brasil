import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:SOS_Brasil/components/snackbar.dart';

import 'package:SOS_Brasil/controllers/session_controller.dart';

import 'package:SOS_Brasil/screens/ForgotPasswordScreen/fp_newpassword.dart';

class InsertPasswordCode extends StatefulWidget {
  InsertPasswordCode({Key key, this.email}) : super(key: key);

  final String email;

  @override
  _InsertPasswordCodeState createState() => _InsertPasswordCodeState();
}

class _InsertPasswordCodeState extends State<InsertPasswordCode> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  TextEditingController textEditingController = TextEditingController();

  bool _isLoading = false;

  _onSubmit(value) async {
    setState(() {
      _isLoading = true;
    });

    if (await SessionController.inserFpCode(value)) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NewPassword(email: widget.email, code: value),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });

      errorController.add(ErrorAnimationType.shake);
      textEditingController.clear();
      CustomSnackbar.showAuthenticationError(context, "Código inexistente");
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
              "Verificação",
              style: TextStyle(fontSize: 24),
            ),
            Icon(Icons.vpn_key, size: 80, color: Colors.grey[600]),
            Text(
              "Insira o código que foi enviado para o seu email.",
              style: TextStyle(fontSize: 21),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            PinCodeTextField(
              length: 6,
              obsecureText: false,
              animationType: AnimationType.fade,
              animationDuration: Duration(milliseconds: 300),
              errorAnimationController: errorController,
              controller: textEditingController,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                selectedColor: Colors.grey,
                inactiveColor: Colors.grey[400],
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              inputFormatters: [UpperCaseTextFormatter()],
              onCompleted: _onSubmit,
              onChanged: (value) {},
              beforeTextPaste: (text) {
                buildShowDialog(text);
                return false;
              },
            ),
            GestureDetector(
              onTap: () {},
              child: RichText(
                text: TextSpan(
                  text: "Não recebeu o código? ",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: "Reenviar",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
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
          "Verificar",
          style: TextStyle(fontSize: 18),
        ),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          String inputValue = textEditingController.text;

          _onSubmit(inputValue);
        },
      ),
    );
  }

  Future buildShowDialog(String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Colar Código"),
        content: RichText(
          text: TextSpan(
            text: "Você deseja colar este código ",
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " ?",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancelar"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Colar"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              textEditingController.text = text;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
