import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final Function onClick;

  const NextButton({Key key, @required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 50,
      child: OutlineButton(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Próximo",
            style: TextStyle(fontSize: 18),
          ),
        ),
        textColor: Colors.white,
        borderSide: BorderSide(color: Colors.white),
        highlightedBorderColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: onClick,
      ),
    );
  }
}
