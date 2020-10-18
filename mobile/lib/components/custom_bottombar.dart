import 'package:flutter/material.dart';
import 'package:SOS_Brasil/components/snackbar.dart';

class CustomBottomBar extends StatelessWidget {
  final Function showPhone;

  const CustomBottomBar({
    Key key,
    this.showPhone,
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
                  CustomSnackbar.showBuildInProgress(context);
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
