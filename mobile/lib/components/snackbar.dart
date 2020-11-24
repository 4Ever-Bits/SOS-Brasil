import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';

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

  static Widget showGeolocationError(BuildContext context) {
    return Flushbar(
      title: "Erro",
      flushbarPosition: FlushbarPosition.TOP,
      message: "Não foi possível recuperar sua localização",
      backgroundColor: Colors.yellow[600],
      duration: Duration(seconds: 5),
    )..show(context);
  }

  static Widget showFileError(BuildContext context) {
    return Flushbar(
      title: "Erro",
      flushbarPosition: FlushbarPosition.TOP,
      message: "Não foi possível salvar o arquivo, tente novamente",
      backgroundColor: Colors.yellow[600],
      duration: Duration(seconds: 5),
    )..show(context);
  }

  static Widget showFileSaveSuccess(BuildContext context) {
    return Flushbar(
      title: "Sucesso",
      flushbarPosition: FlushbarPosition.TOP,
      message: "Arquivo anexado com sucesso",
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
    )..show(context);
  }

  static Widget showBuildInProgress(BuildContext context) {
    return Flushbar(
      title: "Erro",
      flushbarPosition: FlushbarPosition.TOP,
      message: "Não disponível nesta versão",
      backgroundColor: Colors.yellow[600],
      duration: Duration(seconds: 5),
    )..show(context);
  }
}
