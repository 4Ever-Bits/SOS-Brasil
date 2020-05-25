import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/screens/HomeScreen/components/user/user_screen.dart';

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

  void _handleUserClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserConfigTab(user: user),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOS Brasil"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.info,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle,
              size: 30,
            ),
            onPressed: () {
              _handleUserClick();
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Home Screen"),
        ),
      ),
    );
  }
}
