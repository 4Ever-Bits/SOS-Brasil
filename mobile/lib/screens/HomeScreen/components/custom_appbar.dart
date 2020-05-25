import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/screens/HomeScreen/components/user/user_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final User user;
  final BuildContext context;

  const CustomAppBar({Key key, this.user, this.appBar, this.context})
      : super(key: key);

  void _handleUserClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserConfigTab(user: user),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("SOS Brasil"),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.info, size: 30),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle, size: 30),
          onPressed: () {
            _handleUserClick();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
