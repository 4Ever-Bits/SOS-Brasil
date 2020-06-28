import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static Widget showInternetError(BuildContext context) {
    return Flushbar(
      title: "Erro",
      flushbarPosition: FlushbarPosition.TOP,
      message: "Parece que você não possui acesso a internet",
      backgroundColor: Colors.red[600],
      duration: Duration(seconds: 5),
    )..show(context);
  }

  static Widget showAuthenticationError(BuildContext context, String message) {
    return Flushbar(
      title: "Erro",
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      backgroundColor: Colors.yellow[600],
      duration: Duration(seconds: 5),
    )..show(context);
  }
}
