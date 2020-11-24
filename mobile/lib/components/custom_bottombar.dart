import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final Function showPhone;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomBottomBar({
    Key key,
    this.showPhone,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: showPhone,
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}
