import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:SOS_Brasil/components/custom_bottombar.dart';
import 'package:SOS_Brasil/components/custom_close_fab.dart';
import 'package:SOS_Brasil/components/snackbar.dart';
import 'package:SOS_Brasil/utils/sos_clipper.dart';

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
          buildHeader(context),
          SizedBox(height: 60),
          _hasCallSOS ? buildConfirmation(context) : SizedBox(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _hasCallSOS
          ? null
          : CloseFAB(animate: animate, animateIcon: _animateIcon),
    );
  }

  Container buildConfirmation(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Mantenha a calma",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Tente não se mover\nA ajuda está chegando",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 40),
          FloatingActionButton(
            heroTag: "Call",
            onPressed: () {
              CustomSnackbar.showBuildInProgress(context);
            },
            child: Icon(Icons.phone),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Stack buildHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.red, Colors.red[300]],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 2 - 85,
          child: GestureDetector(
            onDoubleTap: _hasCallSOS ? null : _callSOS,
            child: Container(
              height: 170,
              width: 170,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  heroTag: _heroTag,
                  onPressed: _hasCallSOS ? null : () {},
                  elevation: 0,
                  child: buildFABShadow(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding buildFABShadow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        margin: EdgeInsets.all(1),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: buildFABText(),
      ),
    );
  }

  Padding buildFABText() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
        ],
      ),
    );
  }
}
