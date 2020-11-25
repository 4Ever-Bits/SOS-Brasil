import 'package:flutter/material.dart';

import 'package:SOS_Brasil/screens/ServiceCallScreen/components/ServiceScreen/next_button.dart';

Padding buildTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Text(
      "Deseja chamar $title?",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25, color: Colors.white),
    ),
  );
}

Widget buildNextButton(BuildContext context, Function onClick) {
  return GestureDetector(
    onVerticalDragUpdate: (details) {
      if (details.delta.dy < -10) {
        Navigator.of(context).pop();
      }
    },
    child: NextButton(
      onClick: onClick,
    ),
  );
}

Container buildCloseBar(BuildContext context) {
  return Container(
    height: 32,
    child: Center(
      child: Divider(
        color: Colors.white,
        thickness: 1,
        indent: (MediaQuery.of(context).size.width / 2) - 50,
        endIndent: (MediaQuery.of(context).size.width / 2) - 50,
      ),
    ),
  );
}
