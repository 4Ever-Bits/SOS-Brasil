import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:SOS_Brasil/components/snackbar.dart';

import 'package:SOS_Brasil/components/top_box.dart';
import 'package:SOS_Brasil/main.dart';
import 'package:SOS_Brasil/models/session.dart';
import 'package:SOS_Brasil/models/user.dart';
import 'package:SOS_Brasil/screens/SignupScreen/widgets/inputs.dart';
import 'package:SOS_Brasil/controllers/user_controller.dart';

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
      setState(() {
        _isLoading = true;
      });

      //Local form validation
      bool isValid = _formKey.currentState.validate();

      //If the form is valid
      if (isValid) {
        //Save the form values to use here
        _formKey.currentState.save();

        //Signup in API and get an instance of Session
        Session session = await UserController.signup(
            _name, _phoneNumber, _cpf, _email, _password);

        //Save the token on localStorage
        storage.write(key: "token", value: session.token);

        //Get the user JSON of Session instance
        var userJson = userToJson(session.user);
        //Save user JSON in localStorage
        storage.write(key: "user", value: userJson);

        //Move back to starter page
        Navigator.of(context).pop(true);
      }
      //If the form ins't valid
      else {
        //Finish the loading
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      CustomSnackbar.showAuthenticationError(context, e.message);

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
        appBar: AppBar(elevation: 0),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TopBox(title: "Cadastro"),
                buildTextInputFields(),
                buildSignupButton(context),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextInputFields() {
    return Container(
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
              buildPhoneCpfRow(),
              buildEmailFormField(
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
    );
  }

  Padding buildSignupButton(BuildContext context) {
    return Padding(
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
    );
  }

  Row buildPhoneCpfRow() {
    return Row(
      children: <Widget>[
        Flexible(
          child: buildPhoneFormField(
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
          child: buildCPFFormField(
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
    );
  }

  void _togglePswdVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
