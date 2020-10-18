import 'package:flutter/material.dart';
import 'package:SOS_Brasil/components/snackbar.dart';
import 'package:SOS_Brasil/main.dart';
import 'package:SOS_Brasil/models/user.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key key,
    // @required this.user,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User _user;

  @override
  void initState() {
    getStorageUser();
    super.initState();
  }

  getStorageUser() {
    storage.read(key: "user").then((value) {
      setState(() {
        _user = userFromJson(value);
      });
    });
  }

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
            accountName: Text(
                _user != null ? _user.firstName + " " + _user.lastName : ""),
            accountEmail: Text(_user != null ? _user.email : ""),
            currentAccountPicture: CircleAvatar(
              child: Text(
                _user != null ? _user.email[0].toUpperCase() : "",
                style: TextStyle(color: Colors.black87),
              ),
              backgroundColor: Colors.red[100],
            ),
          ),
          ListTile(
            title: Text("Atualizar email"),
            onTap: () {
              CustomSnackbar.showBuildInProgress(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Atualizar senha"),
            onTap: () {
              CustomSnackbar.showBuildInProgress(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Atualizar dados pessoais"),
            onTap: () {
              CustomSnackbar.showBuildInProgress(context);
            },
          ),
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
