import 'package:flutter/material.dart';

import 'package:SOS_Brasil/components/header_with_fab.dart';
import 'package:SOS_Brasil/components/custom_bottombar.dart';
import 'package:SOS_Brasil/components/custom_close_fab.dart';

class SOSScreen extends StatefulWidget {
  SOSScreen({Key key}) : super(key: key);

  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen>
    with SingleTickerProviderStateMixin {
  final String _heroTag = "SOS_BUTTON";

  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;

  bool _hasCallSOS = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    animate();
    super.initState();
  }

  //Animation methods
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
      Navigator.of(context).pop();
    }
    isOpened = !isOpened;
  }

  //Main Method
  _callSOS() {
    setState(() {
      _hasCallSOS = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HeaderWithFAB(
            context: context,
            fabTag: _heroTag,
            onFabDoubleClick: _callSOS,
            child: buildFABText(),
            flag: _hasCallSOS,
            color: Colors.red[400],
          ),
          SizedBox(height: 60),
          _hasCallSOS ? ConfirmText(context: context) : SizedBox(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _hasCallSOS
          ? null
          : CloseFAB(animate: animate, animateIcon: _animateIcon),
    );
  }

  Padding buildFABText() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: !_hasCallSOS
            ? <Widget>[
                Text(
                  "S.O.S",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 2),
                Text(
                  "Clique 2 vezes",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 3.5, letterSpacing: 0.5),
                ),
              ]
            : <Widget>[
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
