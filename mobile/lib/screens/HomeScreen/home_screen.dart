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

class _HomePageState extends State<HomePage> {
  User user;

  List<Service> services = [
    Service("Ambulancia", "192", Colors.red),
    Service("Policia", "190", Colors.indigo[900]),
    Service("Bombeiros", "193", Colors.deepOrange[400]),
  ];

  bool _isSOSActive = false;

  @override
  void initState() {
    storage.read(key: "user").then((value) {
      setState(() {
        user = userFromJson(value);
      });
    });
    super.initState();
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
          body: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(70, 10, 10, 0),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(service: services[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CustomFAB(),
          bottomNavigationBar: CustomBottomBar(),
        ),
        _isSOSActive
            ? Positioned(
                child: SOSScreen(),
              )
            : SizedBox()
      ],
    );
  }
}
