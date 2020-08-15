import 'package:flutter/material.dart';

class CloseFAB extends StatelessWidget {
  final Function animate;
  final Animation<double> animateIcon;

  const CloseFAB({Key key, this.animate, this.animateIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: animate,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animateIcon,
          ),
        ),
      ),
    );
  }
}
