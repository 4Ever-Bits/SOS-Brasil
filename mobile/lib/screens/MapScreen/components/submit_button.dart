import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Color color;
  final Function onClick;

  const SubmitButton({
    Key key,
    @required this.color,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black45,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlatButton(
              color: color,
              child: Text(
                "Pronto",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: onClick,
            ),
          ),
        ),
      ),
    );
  }
}
