import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/models/session.dart';

class SessionController {
  static final String _baseUrl = "http://192.168.0.2:3333";
  static final _header = {"Content-Type": "application/json"};

  static Future<Session> login(String _email, String _password) async {
    String url = _baseUrl + "/signin";

    var payload = json.encode({"email": _email, "password": _password});

    var response = await http
        .post(url, headers: _header, body: payload)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return sessionFromJson(response.body);
    } else {
      throw Exception("Failed to load post");
    }
  }

  static Future<Session> signup(String name, String number, String cpf,
      String email, String password) async {
    String url = _baseUrl + "/signup";

    var payload = json.encode({
      "email": email,
      "password": password,
      "name": name,
      "phone": number,
      "cpf": cpf,
    });

    var response = await http
        .post(url, headers: _header, body: payload)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return await login(email, password);
    } else {
      var errorJson = json.decode(response.body);
      throw Exception(errorJson["error"]);
    }
  }

  static Future<bool> forgotPassword(String email) async {
    String url = _baseUrl + "/forgotpassword";

    var payload = json.encode({
      "email": email,
    });

    var response = await http
        .post(url, headers: _header, body: payload)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200)
      return true;
    else
      return throw Exception("Failed to load post");
  }

  static Future<bool> inserFpCode(String code) async {
    String url = _baseUrl + "/verifyresetcode";

    var payload = json.encode({
      "token": code,
    });

    var response = await http
        .post(url, headers: _header, body: payload)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  static Future<bool> resetPassword(
      String email, String code, String password) async {
    String url = _baseUrl + "/resetpassword";

    var payload = json.encode({
      "email": email,
      "token": code,
      "password": password,
    });

    var response = await http
        .post(url, headers: _header, body: payload)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
