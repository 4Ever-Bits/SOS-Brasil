import 'package:flutter/material.dart';
import 'package:mobile/main.dart';
import 'package:mobile/models/user.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    void _logout() async {
      await storage.deleteAll();
      Navigator.of(context).popAndPushNamed("/start");
    }

    return Container(
      width: ((2 * MediaQuery.of(context).size.width) / 3),
      color: Colors.grey[200],
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
            ),
            accountName: Text(user.firstName + " " + user.lastName),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              child: Text(
                user.email[0].toUpperCase(),
                style: TextStyle(color: Colors.black87),
              ),
              backgroundColor: Colors.red[100],
            ),
          ),
          ListTile(title: Text("Atualizar email")),
          Divider(),
          ListTile(title: Text("Atualizar senha")),
          Divider(),
          ListTile(title: Text("Atualizar dados pessoais")),
          Divider(),
          ListTile(
            title: Text("Sair"),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }
}
