import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "SOS Brasil",
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SOS Brasil"),
        ),
        body: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
