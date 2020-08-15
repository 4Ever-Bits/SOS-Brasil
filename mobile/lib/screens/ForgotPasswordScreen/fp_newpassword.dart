import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mobile/components/snackbar.dart';
import 'package:mobile/controllers/session_controller.dart';

class NewPassword extends StatefulWidget {
  NewPassword({Key key, this.email, this.code}) : super(key: key);
  final String email;
  final String code;

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _obscureText = true;
  bool _isLoading = false;
  String _password;

  _onSubmit() async {
    setState(() {
      _isLoading = true;
    });

    if (await SessionController.resetPassword(
        widget.email, widget.code, _password)) {
      Navigator.pop(context);
    } else {
      setState(() {
        _isLoading = false;
      });
      CustomSnackbar.showAuthenticationError(
          context, "Não foi possível alterar a senha");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.white60,
      isLoading: _isLoading,
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  Container buildBody() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Redefinir a senha",
              style: TextStyle(fontSize: 24),
            ),
            Icon(Icons.vpn_key, size: 80, color: Colors.grey[600]),
            Text(
              "Insira uma nova senha.",
              style: TextStyle(fontSize: 21),
            ),
            Text(
              "Essa senha deve conter pelo menos 6 dígitos, e para maior segurança misture letras, números e sinais de pontuação.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.justify,
            ),
            buildTextField(),
            buildButton(),
          ],
        ),
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: "Insira a nova senha",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 10.0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: IconButton(
            onPressed: () {
              _togglePswdVisibility();
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              size: 26,
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
      ),
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Container buildButton() {
    return Container(
      width: 140,
      height: 50,
      child: FlatButton(
        child: Text(
          "Continuar",
          style: TextStyle(fontSize: 18),
        ),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: _onSubmit,
      ),
    );
  }

  void _togglePswdVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
