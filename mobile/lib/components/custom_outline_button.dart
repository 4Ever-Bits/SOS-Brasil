import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color color;

  const CustomButton({Key key, this.text, this.function, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: color,
        ),
      ),
      borderSide: BorderSide(color: color),
      highlightedBorderColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
