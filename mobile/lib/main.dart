import 'package:flutter/material.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:mobile/pages/login_page.dart';

void main() {
  runApp(MaterialApp(
    title: "SOS Brasil",
    home: HomePage(),
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red[400],
      accentColor: Colors.red,
      fontFamily: "Roboto",
    ),
  ));
}

class HomePage extends StatelessWidget {
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
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          "SOS Brasil",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        OutlineButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(_createRoute(LoginPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Entrar",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                          highlightedBorderColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(_createRoute(SignupPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.red[400]),
                            ),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
