import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

TextFormField buildPasswordFormField(
    [Function togglePswdVisibility,
    bool isObscureText = false,
    Function onSave]) {
  return TextFormField(
    validator: (value) {
      if (value.isNotEmpty)
        return null;
      else
        return "Password is empty";
    },
    onSaved: (value) {
      onSave(value);
    },
    obscureText: isObscureText,
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
            togglePswdVisibility();
          },
          icon: Icon(isObscureText ? Icons.visibility_off : Icons.visibility,
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
  );
}

TextFormField buildTextFormField(String text, IconData icon,
    [MaskTextInputFormatter formatter, Function onSave]) {
  return TextFormField(
    validator: (value) {
      if (value.isNotEmpty)
        return null;
      else
        return "$text is empty";
    },
    onSaved: (value) {
      onSave(value);
    },
    inputFormatters: formatter != null ? [formatter] : null,
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Icon(icon, size: 26),
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      labelText: text,
      labelStyle: TextStyle(fontSize: 15),
    ),
  );
}
