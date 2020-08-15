import 'package:flutter/material.dart';

class CentralCard extends StatelessWidget {
  final List<Widget> childrens;
  final Color color;

  const CentralCard({
    Key key,
    @required this.childrens,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 391,
        width: 324,
        child: Card(
          color: color,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Selecione a opção",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 63),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: childrens,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
