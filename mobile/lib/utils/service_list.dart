import 'package:flutter/material.dart';
import 'package:SOS_Brasil/models/service.dart';

List<Service> getServiceList() {
  List<Service> services = [
    Service(
      "Ambulância",
      "192",
      Colors.red,
      "assets/svgs/samu.svg",
    ),
    Service(
      "Polícia",
      "190",
      Colors.indigo[900],
      "assets/svgs/policia.svg",
    ),
    Service(
      "Bombeiros",
      "193",
      Colors.deepOrange[400],
      "assets/svgs/bombeiro.svg",
    ),
  ];

  return services;
}
