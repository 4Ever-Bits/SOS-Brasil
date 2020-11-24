import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:SOS_Brasil/animations/transitions.dart';

import 'package:SOS_Brasil/components/emergency_list.dart';

import 'package:SOS_Brasil/screens/LoginScreen/login_screen.dart';
import 'package:SOS_Brasil/screens/SignupScreen/signup_screen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Permission.location.request().then((_) {
      Permission.microphone.request().then((_) {
        Permission.accessMediaLocation.request().then((_) {
          print("has permissions");
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.red[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              color: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => EmergencyList(),
                );
              },
            ),
          ],
        ),
      ),
      body: Theme(
        data: ThemeData(primaryColor: Colors.amber[100]),
        child: Container(
          decoration: BoxDecoration(color: Colors.red[400]),
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 150),
                    Text(
                      "SOS Brasil",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 150),
                    OutlineButton(
                      onPressed: () async {
                        dynamic response = await Navigator.of(context)
                            .push(createSlideUpRoute(LoginPage()));

                        if (response != null && response)
                          Navigator.of(context).popAndPushNamed("/home");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.white),
                      highlightedBorderColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      onPressed: () async {
                        dynamic response = await Navigator.of(context)
                            .push(createSlideUpRoute(SignupPage()));
                        if (response != null && response)
                          Navigator.of(context).popAndPushNamed("/home");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red[400],
                          ),
                        ),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
