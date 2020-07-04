import 'package:flutter/material.dart';

import 'package:mobile/models/service.dart';

import 'package:mobile/screens/ServiceCallScreen/components/ServiceDialog/build_methods.dart';

import 'package:mobile/screens/ServiceCallScreen/service_screen.dart';

import 'package:mobile/animations/transitions.dart';

class ServiceDialog {
  Map<String, double> _userLocation;
  BuildContext _context;
  Service _service;
  Color _color;
  int _userId;

  void pushToServiceScreen() {
    Navigator.of(_context).push(
      createSlideDownRoute(
        ServiceScreen(
          color: _color,
          location: _userLocation,
          title: getModalTitle(_service.name),
          userId: _userId,
        ),
      ),
    );
  }

  Future showServiceDialog(BuildContext context, Service service,
      Map<String, double> userLocation, int userId) {
    _color = getModalColor(service.name);
    _userLocation = userLocation;
    _context = context;
    _service = service;
    _userId = userId;

    return showGeneralDialog(
      context: _context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.white.withOpacity(0.0),
      pageBuilder: (context, animation, secondaryAnimation) {
        return buildPageBuilder();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return buildServiceModalTransition(animation, child);
      },
    );
  }

  Column buildPageBuilder() {
    var boxDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(blurRadius: 5, color: Colors.black45, spreadRadius: 5)
      ],
      color: _color,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(_context).size.width,
          decoration: boxDecoration,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 10) {
                pushToServiceScreen();
              }
            },
            onTap: pushToServiceScreen,
            child: buildCard(),
          ),
        ),
      ],
    );
  }

  Card buildCard() {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
        child: Column(
          children: <Widget>[
            Text(
              "Deseja chamar ${getModalTitle(_service.name)}?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Container(
              height: 32,
              child: Center(
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: (MediaQuery.of(_context).size.width / 2) - 70,
                  endIndent: (MediaQuery.of(_context).size.width / 2) - 70,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
