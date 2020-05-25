import 'package:flutter/material.dart';
import 'package:mobile/screens/SosScreen/sos_screen.dart';

class CustomFAB extends StatelessWidget {
  final String _heroTag = "SOS_BUTTON";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: _heroTag,
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    SOSScreen(),
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
          child: Text("SOS"),
          elevation: 2.0,
        ),
      ),
    );
  }
}
