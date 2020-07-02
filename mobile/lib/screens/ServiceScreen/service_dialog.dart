import 'package:flutter/material.dart';
import 'package:mobile/animations/transitions.dart';
import 'package:mobile/models/service.dart';
import 'package:mobile/screens/ServiceScreen/service_screen.dart';

class ServiceDialog {
  void verticalDrag(context, details, color, service) {
    if (details.delta.dy > 10) {
      Navigator.of(context).push(
        createSlideDownRoute(
          ServiceScreen(
            color: color,
            title: getModalTitle(service.name),
          ),
        ),
      );
    }
  }

  Future showServiceDialog(BuildContext context, Service service) {
    Color color = getModalColor(service.name);

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.white.withOpacity(0.0),
      pageBuilder: (context, animation, secondaryAnimation) {
        return buildPageBuilder(context, color, service);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return buildServiceModalTransition(animation, child);
      },
    );
  }

  Column buildPageBuilder(BuildContext context, Color color, Service service) {
    var boxDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(blurRadius: 5, color: Colors.black45, spreadRadius: 5)
      ],
      color: color,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: boxDecoration,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              verticalDrag(context, details, color, service);
            },
            onTap: () {
              Navigator.of(context).push(
                createSlideDownRoute(
                  ServiceScreen(
                    color: color,
                    title: getModalTitle(service.name),
                  ),
                ),
              );
            },
            child: buildCard(color, service, context),
          ),
        ),
      ],
    );
  }

  Card buildCard(Color color, Service service, context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
        child: Column(
          children: <Widget>[
            Text(
              "Deseja chamar uma ${service.name}?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Container(
              height: 32,
              child: Center(
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: (MediaQuery.of(context).size.width / 2) - 70,
                  endIndent: (MediaQuery.of(context).size.width / 2) - 70,
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

  getModalTitle(String serviceName) {
    switch (serviceName) {
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
