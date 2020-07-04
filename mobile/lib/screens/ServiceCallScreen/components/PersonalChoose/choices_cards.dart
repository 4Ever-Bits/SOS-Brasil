import 'package:flutter/material.dart';

class ForMeCard extends StatelessWidget {
  final Function builder;

  const ForMeCard({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          LayoutBuilder(builder: builder),
          SizedBox(height: 5),
          Text(
            "para mim",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class ForOtherCard extends StatelessWidget {
  final Function builder;

  const ForOtherCard({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: builder,
          ),
          SizedBox(height: 5),
          Text(
            "para outro",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
