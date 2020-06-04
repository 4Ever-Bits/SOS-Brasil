import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mobile/screens/HomeScreen/home_screen.dart';
import 'package:mobile/screens/InfoScreen/info_screen.dart';
import 'package:mobile/screens/SignupScreen/signup_screen.dart';
import 'package:mobile/screens/login_screen.dart';

import 'package:mobile/animations/route_bottom_top.dart';

// Create storage
final storage = new FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    storage.read(key: "user").then((value) {
      Widget initWidget = value != null ? HomePage() : LandingPage();

      runApp(MaterialApp(
        title: "SOS Brasil",
        routes: {
          "/": (context) => initWidget,
          "/home": (context) => HomePage(),
          "/start": (context) => LandingPage(),
          "/info": (context) => InfoScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red[400],
          accentColor: Colors.red,
          scaffoldBackgroundColor: Colors.grey[300],
          canvasColor: Colors.transparent,
          fontFamily: "Roboto",
        ),
      ));
    });
  });
}

class LandingPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            .push(createRoute(LoginPage()));

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
                            .push(createRoute(SignupPage()));
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
