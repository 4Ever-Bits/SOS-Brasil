import 'package:flutter/material.dart';

class CloseBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: Center(
        child: Divider(
          color: Colors.white,
          thickness: 1,
          indent: (MediaQuery.of(context).size.width / 2) - 25,
          endIndent: (MediaQuery.of(context).size.width / 2) - 25,
        ),
      ),
    );
  }
}
