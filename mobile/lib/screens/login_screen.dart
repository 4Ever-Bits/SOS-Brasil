import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mobile/components/top_box.dart';
import 'package:mobile/controllers/login_controller.dart';
import 'package:mobile/models/session.dart';
import 'package:mobile/models/user.dart';

final storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email, _password;
  bool _isLoading = false;
  bool _hasError = false;

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
        print(userJson);
        storage.write(key: "user", value: userJson);

        Navigator.of(context).pop(true);
      }
    } catch (e) {
      print(e);
      _formKey.currentState.reset();
      setState(() {
        _isLoading = false;
      });

      //TODO: Show the error to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.white60,
      isLoading: _isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(elevation: 0),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TopBox(title: "Login"),
              Padding(
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
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("Esqueceu a senha?"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
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
              ),
              SizedBox(height: 60)
            ],
          ),
        ),
      ),
    );
  }

  void _togglePswdVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
