import 'package:flutter/material.dart';

import 'package:SOS_Brasil/models/user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final User user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;

  const CustomAppBar(
      {Key key, this.user, this.appBar, this.context, this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("SOS Brasil"),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.info, size: 30),
        onPressed: () {
          Navigator.of(context).pushNamed("/info");
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle, size: 30),
          onPressed: () {
            // _handleUserClick();
            scaffoldKey.currentState.openEndDrawer();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
