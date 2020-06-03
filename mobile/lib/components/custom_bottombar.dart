import 'package:flutter/material.dart';

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
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: showPhone,
                child: Icon(
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
