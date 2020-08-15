import 'package:flutter/material.dart';

getModalColor(String serviceName) {
  switch (serviceName) {
    case "Ambulância":
      return Colors.red[400];
      break;

    case "Polícia":
      return Colors.indigo;
      break;

    case "Bombeiros":
      return Colors.deepOrange[400];
      break;

    default:
      return Colors.red[400];
      break;
  }
}

getModalTitle(String serviceName) {
  switch (serviceName) {
    case "Ambulância":
      return "uma Ambulância";
      break;

    case "Polícia":
      return "uma Viatura";
      break;

    case "Bombeiros":
      return "o Corpo de Bombeiros";
      break;

    default:
      return "uma Ambulância";
      break;
  }
}
