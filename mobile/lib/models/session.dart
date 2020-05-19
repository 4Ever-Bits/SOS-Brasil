// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';
import 'package:mobile/models/user.dart';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  String message;
  User user;
  String token;

  Session({
    this.message,
    this.user,
    this.token,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
        "token": token,
      };
}
