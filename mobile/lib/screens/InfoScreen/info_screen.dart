import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  TextStyle outsideStyle = TextStyle(color: Colors.black87, fontSize: 24);
  TextStyle insideStyle = TextStyle(color: Colors.white, fontSize: 20);

  String aboutUs = "I ❤️ Flutter";
  String appVersion = "1.0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOS Brasil"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sobre Nós",
              style: outsideStyle,
            ),
            SizedBox(height: 22),
            Text(
              "Desenvolvedores",
              style: outsideStyle,
            ),
            SizedBox(height: 22),
            buildContainer(
              Column(
                children: <Widget>[
                  Text(
                    "Pedro Henrique",
                    style: insideStyle,
                  ),
                  Text(
                    "Meily Cristini",
                    style: insideStyle,
                  ),
                  Text(
                    "Emilly Rafaele",
                    style: insideStyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),
            Text(
              "Versão",
              style: outsideStyle,
            ),
            SizedBox(height: 22),
            GestureDetector(
              onLongPress: () => showAboutDialog(
                context: context,
                applicationVersion: appVersion,
                children: [Text(aboutUs)],
              ),
              child: buildContainer(
                Column(
                  children: <Widget>[
                    Text(
                      appVersion,
                      style: insideStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(Widget child) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: child,
      ),
    );
  }
}
