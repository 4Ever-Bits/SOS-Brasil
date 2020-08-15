import 'dart:io';

import 'package:flutter/material.dart';

class Call {
  String title;
  String description;
  bool isPersonal;
  double latitude;
  double longitude;
  int userId;
  File imageFile;
  File audioFile;

  Call(
      {@required this.title,
      @required this.description,
      this.isPersonal,
      @required this.latitude,
      @required this.longitude,
      this.userId,
      this.imageFile,
      this.audioFile});
}
