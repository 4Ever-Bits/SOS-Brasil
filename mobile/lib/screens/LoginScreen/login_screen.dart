import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:SOS_Brasil/components/top_box.dart';
import 'package:SOS_Brasil/components/snackbar.dart';

import 'package:SOS_Brasil/controllers/login_controller.dart';

import 'package:SOS_Brasil/models/user.dart';
import 'package:SOS_Brasil/models/session.dart';

final storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email, _password;
  bool _isLoading = false;

  bool _obscureText = true;

  _onSubmit() async {
    try {
      setState(() {
        _isLoading = true;
      });

      bool isValid = _formKey.currentState.validate();
      if (isValid) {
        _formKey.currentState.save();

        Session session = await LoginController.login(_email, _password);
        storage.write(key: "token", value: session.token);

        var userJson = userToJson(session.user);
        storage.write(key: "user", value: userJson);

        Navigator.of(context).pop(true);
      } else
        setState(() {
          _isLoading = false;
        });
    } catch (e) {
      _formKey.currentState.reset();
      setState(() {
        _isLoading = false;
      });

      CustomSnackbar.showAuthenticationError(
          context, "Email ou senha está inserido incorretamente");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.white60,
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TopBox(title: "Login"),
                SizedBox(height: 60),
                buildTextFields(context),
                buildLoginButton(context),
                SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: FlatButton(
        onPressed: _onSubmit,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Padding buildTextFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.email, size: 26),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 15),
              ),
              validator: (value) {
                if (value.isEmpty) return "Email está vazio";
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            TextFormField(
              obscureText: _obscureText,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.vpn_key, size: 26),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                    onPressed: () {
                      _togglePswdVisibility();
                    },
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 26),
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                labelText: "Senha",
                labelStyle: TextStyle(fontSize: 15),
              ),
              validator: (value) {
                if (value.isEmpty) return "Senha está vazio";
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 20),
            buildForgotPassword()
          ],
        ),
      ),
    );
  }

  Row buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/forgotpassword");
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Esqueceu a senha?"),
        )
      ],
    );
  }

  void _togglePswdVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
