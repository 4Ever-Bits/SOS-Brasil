import 'package:SOS_Brasil/controllers/notification_controller.dart';
import 'package:SOS_Brasil/main.dart';
import 'package:SOS_Brasil/models/call.dart';
import 'package:flutter/material.dart';

import 'package:SOS_Brasil/components/header_with_fab.dart';

class CallTrackingScreen extends StatelessWidget {
  CallTrackingScreen({
    Key key,
    @required this.color,
    @required this.call,
    @required this.service,
  }) : super(key: key);

  final String service;
  final Color color;
  final Call call;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWithFAB(
            flag: true,
            context: context,
            child: buildFABText(),
            color: color,
          ),
          SizedBox(height: 60),
          ConfirmText(
            context: context,
            color: color,
            service: service,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(height: kBottomNavigationBarHeight - 10),
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () async {
          await NotificationController.cancellAll();
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
