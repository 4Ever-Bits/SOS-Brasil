import 'package:flutter/material.dart';
import 'package:mobile/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(service.name);
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4.8,
            decoration: buildBoxDecoration(),
          ),
          Positioned(
            right: 20,
            top: 15,
            child: Container(
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    width: 1,
                    color: Colors.white.withOpacity(.85),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  service.name,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.85),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: service.color,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 6,
          offset: Offset(0, 3),
        )
      ],
    );
  }
}
