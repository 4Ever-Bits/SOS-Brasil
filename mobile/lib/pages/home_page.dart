import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final storage = new FlutterSecureStorage();

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;

  @override
  void initState() {
    storage.read(key: "user").then((value) {
      setState(() {
        user = userFromJson(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(user.firstName);

    return Scaffold(
      appBar: AppBar(
        title: Text("SOS Brasil"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text(user.firstName == null ? "Sem Nome" : user.firstName),
        ),
      ),
    );
  }
}
