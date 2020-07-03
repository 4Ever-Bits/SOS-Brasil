import 'package:flutter/material.dart';
import 'package:mobile/animations/transitions.dart';
import 'package:mobile/models/service.dart';
import 'package:mobile/screens/ServiceScreen/service_screen.dart';

class ServiceDialog {
  Map<String, double> _userLocation;
  BuildContext _context;
  Service _service;
  Color _color;

  void pushToServiceScreen() {
    Navigator.of(_context).push(
      createSlideDownRoute(
        ServiceScreen(
          color: _color,
          location: _userLocation,
          title: getModalTitle(),
        ),
      ),
    );
  }

  Future showServiceDialog(
      BuildContext context, Service service, Map<String, double> userLocation) {
    _color = getModalColor(service.name);
    _userLocation = userLocation;
    _context = context;
    _service = service;

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

  void verticalDrag(details) {
    if (details.delta.dy > 10) {
      pushToServiceScreen();
    }
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
            onVerticalDragUpdate: verticalDrag,
            onTap: () {
              pushToServiceScreen();
            },
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
              "Deseja chamar ${getModalTitle()}?",
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

  getModalColor(String serviceName) {
    switch (serviceName) {
      case "Ambulância":
        return Colors.red[400];
        break;

      case "Polícia":
        return Colors.indigo;
        break;

      case "Bombeiros":
        return Colors.deepOrange[400];
        break;

      default:
        return Colors.red[400];
        break;
    }
  }

  getModalTitle() {
    switch (_service.name) {
      case "Ambulância":
        return "uma Ambulância";
        break;

      case "Polícia":
        return "uma Viatura";
        break;

      case "Bombeiros":
        return "o Corpo de Bombeiros";
        break;

      default:
        return "uma Ambulância";
        break;
    }
  }
}
