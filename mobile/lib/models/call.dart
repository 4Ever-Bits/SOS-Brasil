import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

Call callFromJson(String str) => Call.fromJson(json.decode(str));

String callToJson(Call data) => json.encode(data.toJson());

class Call {
  String title;
  String description;
  bool isPersonal;
  double latitude;
  double longitude;
  int userId;
  File imageFile;
  File audioFile;

  Call({
    @required this.title,
    @required this.description,
    this.isPersonal,
    @required this.latitude,
    @required this.longitude,
    this.userId,
    this.imageFile,
    this.audioFile,
  });

  factory Call.fromJson(Map<String, dynamic> json) => Call(
        title: json["title"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Future<Map<String, dynamic>> toJson() async => {
        "title": this.title,
        "description": this.description,
        "isPersonal": this.isPersonal.toString(),
        "latitude": this.latitude.toString(),
        "longitude": this.longitude.toString(),
        "user_id": this.userId.toString(),
        "audio_file":
            this.audioFile != null ? await this.audioFile.readAsBytes() : null,
        "image_file":
            this.imageFile != null ? await this.imageFile.readAsBytes() : null,
      };
}
