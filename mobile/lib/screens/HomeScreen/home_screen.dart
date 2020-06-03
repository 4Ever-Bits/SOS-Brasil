import 'package:flutter/material.dart';
import 'package:mobile/components/custom_bottombar.dart';
import 'package:mobile/components/custom_fab.dart';
import 'package:mobile/models/service.dart';
import 'package:mobile/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/screens/HomeScreen/components/card/service_card.dart';
import 'package:mobile/screens/HomeScreen/components/custom_appbar.dart';
import 'package:mobile/screens/HomeScreen/components/user/user_screen.dart';
import 'package:mobile/screens/SosScreen/sos_screen.dart';

// Create storage
final storage = new FlutterSecureStorage();

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  User user;

  List<Service> services = [
    Service(
      "Ambulância",
      "192",
      Colors.red,
      "assets/svgs/samu.svg",
    ),
    Service(
      "Polícia",
      "190",
      Colors.indigo[900],
      "assets/svgs/policia.svg",
    ),
    Service(
      "Bombeiros",
      "193",
      Colors.deepOrange[400],
      "assets/svgs/bombeiro.svg",
    ),
  ];

  bool _isSOSActive = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    storage.read(key: "user").then((value) {
      setState(() {
        user = userFromJson(value);
      });
    });

    _controller = new AnimationController(
      duration: const Duration(milliseconds: 100),
      value: 0.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  toggleBackdrop() {
    _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
    setState(() {
      _isVisible = _isPanelVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: CustomAppBar(
            appBar: AppBar(),
            context: context,
            user: user,
          ),
          body: LayoutBuilder(builder: buildStack),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _isVisible ? null : CustomFAB(),
          bottomNavigationBar:
              _isVisible ? null : CustomBottomBar(showPhone: toggleBackdrop),
        ),
        _isSOSActive ? Positioned(child: SOSScreen()) : SizedBox()
      ],
    );
  }

  Container buildContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: <Widget>[
            ServiceCard(service: services[0]),
            SizedBox(height: 10),
            ServiceCard(service: services[1]),
            SizedBox(height: 10),
            ServiceCard(service: services[2]),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    return Container(
      child: Stack(
        children: <Widget>[
          buildContainer(),
          PositionedTransition(
            rect: animation,
            child: GestureDetector(
              onTap: toggleBackdrop,
              child: Material(
                elevation: 12.0,
                borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo[900], Colors.indigo[300]],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 32,
                        child: Center(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                            indent:
                                (MediaQuery.of(context).size.width / 2) - 25,
                            endIndent:
                                (MediaQuery.of(context).size.width / 2) - 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text("content"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height;
    final double bottom = -32;
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: RelativeRect.fromLTRB(0.0, 100, 0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }
}
