import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:mobile/components/top_box.dart';
import 'package:mobile/main.dart';
import 'package:mobile/models/session.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/screens/SignupScreen/widgets/inputs.dart';
import 'package:mobile/controllers/user_controller.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  String _phoneNumber;
  String _cpf;

  bool _obscureText = true;
  bool _isLoading = false;

  _onSubmit() async {
    try {
      bool isValid = _formKey.currentState.validate();

      if (isValid) {
        setState(() {
          _isLoading = true;
        });
        _formKey.currentState.save();
        Session session = await UserController.signup(
            _name, _phoneNumber, _cpf, _email, _password);

        storage.write(key: "token", value: session.token);

        var userJson = userToJson(session.user);
        print(userJson);
        storage.write(key: "user", value: userJson);

        Navigator.of(context).pop(true);
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
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
              TopBox(title: "Cadastro"),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        buildTextFormField(
                          "Nome",
                          Icons.person,
                          null,
                          (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: buildTextFormField(
                                "Telefone",
                                Icons.phone,
                                MaskTextInputFormatter(
                                  mask: "(##) #####-####",
                                  filter: {
                                    "#": RegExp(r'[0-9]'),
                                  },
                                ),
                                (value) {
                                  setState(() {
                                    _phoneNumber = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: buildTextFormField(
                                "CPF",
                                Icons.assignment,
                                MaskTextInputFormatter(
                                  mask: "###.###.###-##",
                                  filter: {
                                    "#": RegExp(r'[0-9]'),
                                  },
                                ),
                                (value) {
                                  setState(() {
                                    _cpf = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        buildTextFormField(
                          "Email",
                          Icons.email,
                          null,
                          (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        ),
                        buildPasswordFormField(
                          _togglePswdVisibility,
                          _obscureText,
                          (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  onPressed: _onSubmit,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Cadastrar",
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
              SizedBox(height: 30)
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
