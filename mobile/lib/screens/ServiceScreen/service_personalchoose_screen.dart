import 'package:flutter/material.dart';

import 'package:mobile/models/call.dart';

class PersonalChooseScreen extends StatefulWidget {
  // final double latitude, longitude;
  // final String title, description;
  final Call call;
  final Color color;

  const PersonalChooseScreen({Key key, this.call, this.color})
      : super(key: key);

  @override
  _PersonalChooseScreenState createState() => _PersonalChooseScreenState();
}

class _PersonalChooseScreenState extends State<PersonalChooseScreen> {
  int activeIndex;

  Call call;

  @override
  void initState() {
    call = widget.call;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: Center(
        child: Container(
          height: 391,
          width: 324,
          child: Card(
            color: Colors.red,
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
                    children: <Widget>[
                      buildForMeCard(),
                      buildForOtherCard(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildForOtherCard() {
    return Container(
      width: 127,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeIndex = 0;
          });

          print(activeIndex);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              LayoutBuilder(
                builder: (context, constraints) {
                  //TODO build color change logic

                  if (activeIndex == null || activeIndex != 0) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.grey, BlendMode.saturation),
                        child: Image.asset("assets/images/forOtherRed.png"),
                      ),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset("assets/images/forOtherRed.png"),
                    );
                  }
                },
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
        ),
      ),
    );
  }

  Container buildForMeCard() {
    return Container(
      width: 127,
      height: 200,
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeIndex = 1;
          });

          print(activeIndex);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              LayoutBuilder(
                builder: (context, constraints) {
                  if (activeIndex == null || activeIndex != 1) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.grey, BlendMode.saturation),
                        child: Image.asset("assets/images/forMeRed.png"),
                      ),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.asset("assets/images/forMeRed.png"),
                    );
                  }
                },
              ),
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
        ),
      ),
    );
  }
}
