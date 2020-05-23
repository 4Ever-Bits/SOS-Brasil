import 'package:flutter/material.dart';
import 'package:mobile/main.dart';

import 'package:mobile/components/custom_outline_button.dart';
import 'package:mobile/models/user.dart';

class UserConfigTab extends StatelessWidget {
  final User user;

  const UserConfigTab({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
    );

    void _logout() async {
      await storage.deleteAll();
      Navigator.of(context).popAndPushNamed("/start");
    }

    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100),
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      user.firstName + " " + user.lastName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  ButtonAligned(
                    button: CustomButton(
                      text: "Atualizar email",
                      color: Theme.of(context).primaryColor,
                      function: () {},
                    ),
                  ),
                  ButtonAligned(
                    button: CustomButton(
                      text: "Atualizar senha",
                      color: Theme.of(context).primaryColor,
                      function: () {},
                    ),
                  ),
                  ButtonAligned(
                    button: CustomButton(
                      text: "Atualizar dados pessoais",
                      color: Theme.of(context).primaryColor,
                      function: () {},
                    ),
                  ),
                  ButtonAligned(
                    button: CustomButton(
                      text: "Sair",
                      color: Theme.of(context).primaryColor,
                      function: () {
                        _logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: (MediaQuery.of(context).size.width / 2) - 65,
            child: CircleAvatar(
              radius: 65,
            ),
          )
        ],
      ),
    );
  }
}

class ButtonAligned extends StatelessWidget {
  final Widget button;

  const ButtonAligned({Key key, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70), child: button);
  }
}
