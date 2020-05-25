import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/custom_bottombar.dart';

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

  Widget toggleFab() {
    return Container(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: animate,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animateIcon,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildHeader(context),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: toggleFab(),
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
            onDoubleTap: () {
              print("pressed");
            },
            child: Container(
              height: 170,
              width: 170,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  heroTag: _heroTag,
                  onPressed: () {},
                  elevation: 0,
                  child: Padding(
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
                      child: Padding(
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
                              style:
                                  TextStyle(fontSize: 3.5, letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 110);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 110);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
