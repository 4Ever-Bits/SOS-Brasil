import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/session.dart';

class LoginController {
  static Future<Session> login(String _email, String _password) async {
    String url = "http://192.168.0.2:3333/signin";

    var header = {"Content-Type": "application/json"};

    var body = json.encode({"email": _email, "password": _password});

    var response = await http
        .post(url, headers: header, body: body)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return sessionFromJson(response.body);
    } else {
      throw Exception("Failed to load post");
    }
  }
}
