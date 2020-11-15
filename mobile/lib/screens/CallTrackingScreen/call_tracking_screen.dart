import 'package:flutter/material.dart';

import 'package:SOS_Brasil/components/header_with_fab.dart';

class CallTrackingScreen extends StatelessWidget {
  CallTrackingScreen({
    Key key,
    this.color,
    this.headerText,
  }) : super(key: key);

  final Color color;
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWithFAB(
            flag: true,
            context: context,
            child: buildFABText(),
            // color: color,
            // headerText: headerText,
          ),
          SizedBox(height: 60),
          ConfirmText(context: context),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(height: kBottomNavigationBarHeight - 10),
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.close,
          size: 26,
        ),
      ),
    );
  }

  Widget buildFABText() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Aguarde",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9),
          ),
        ],
      ),
    );
  }
}
