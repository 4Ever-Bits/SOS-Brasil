import 'package:flutter/material.dart';

import 'package:mobile/models/call.dart';

import 'package:mobile/screens/ServiceCallScreen/components/PersonalChoose/build_methods.dart';
import 'package:mobile/screens/ServiceCallScreen/components/PersonalChoose/central_card.dart';
import 'package:mobile/screens/ServiceCallScreen/components/PersonalChoose/choices_cards.dart';

import 'package:mobile/screens/CallWaitingScreen/waiting_screen.dart';

class PersonalChooseScreen extends StatefulWidget {
  final Call call;
  final Color color;
  final String url;

  const PersonalChooseScreen({Key key, this.call, this.color, this.url})
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

  handleSubmit() {
    switch (activeIndex) {
      case 0:
        call.isPersonal = true;
        break;

      default:
        call.isPersonal = false;
        break;
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => WaitingScreen(
        call: call,
        color: widget.color,
        url: widget.url,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: <Widget>[
          CentralCard(
            color: getCardColor(widget.color),
            childrens: <Widget>[
              buildForMeCard(),
              buildForOtherCard(),
            ],
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (activeIndex != null) {
                    return buildSubmitButton(handleSubmit);
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
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
        },
        child: ForOtherCard(
          builder: (context, constraints) {
            String url =
                "assets/images/forOther${getImageString(widget.color)}.png";

            if (activeIndex == null || activeIndex != 0)
              return buildImageGreyFilter(url);
            else
              return buildImage(url);
          },
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
        },
        child: ForMeCard(
          builder: (context, constraints) {
            String url =
                "assets/images/forMe${getImageString(widget.color)}.png";

            if (activeIndex == null || activeIndex != 1)
              return buildImageGreyFilter(url);
            else
              return buildImage(url);
          },
        ),
      ),
    );
  }
}
