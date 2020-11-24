import 'dart:io';

import 'package:SOS_Brasil/components/custom_left_drawer.dart';
import 'package:flutter/material.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:SOS_Brasil/components/snackbar.dart';
import 'package:SOS_Brasil/components/custom_fab.dart';
import 'package:SOS_Brasil/components/custom_drawer.dart';
import 'package:SOS_Brasil/components/emergency_list.dart';
import 'package:SOS_Brasil/components/custom_bottombar.dart';

import 'package:SOS_Brasil/controllers/location_controller.dart';
import 'package:SOS_Brasil/controllers/service_controller.dart';

import 'package:SOS_Brasil/models/service.dart';
import 'package:SOS_Brasil/models/user.dart';

import 'package:SOS_Brasil/screens/HomeScreen/components/card/service_card.dart';
import 'package:SOS_Brasil/screens/HomeScreen/components/custom_appbar.dart';
import 'package:SOS_Brasil/screens/SosScreen/sos_screen.dart';

import 'package:SOS_Brasil/utils/service_list.dart';

// Create storage
final storage = new FlutterSecureStorage();

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Service> services = getServiceList();
  final LocationController locationController = LocationController();
  User user;

  Map<String, double> userLocation;
  Map<String, String> serverUrl;

  bool _isSOSActive = false;
  bool _isLoading = true;
  bool hasInternet;

  @override
  void initState() {
    super.initState();
    try {
      getStorageUser();

      checkInternet();

      getUserLocation();
    } catch (e) {}
  }

  getUserLocation() {
    locationController.getCurrentLocation().then((location) {
      Map<String, String> url = ServiceController()
          .getUrl(location["latitude"], location["longitude"]);

      setState(() {
        userLocation = location;
        serverUrl = url;
        _isLoading = false;
      });
    }).catchError((e) {
      print(e);
      CustomSnackbar.showGeolocationError(context);
      setState(() {
        _isLoading = false;
      });
    });
  }

  getStorageUser() {
    storage.read(key: "user").then((value) {
      setState(() {
        user = userFromJson(value);
      });
    });
  }

  checkInternet() {
    InternetAddress.lookup('google.com').then((result) {
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          hasInternet = true;
        });
      }
    }).catchError((_) {
      CustomSnackbar.showInternetError(context);
      toggleBackdrop();
      setState(() {
        hasInternet = false;
      });
    });
  }

  logout() async {
    await storage.deleteAll();
    Navigator.of(context).popAndPushNamed("/start");
  }

  toggleBackdrop() {
    showModalBottomSheet(
      context: context,
      builder: (context) => EmergencyList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.white60,
      isLoading: _isLoading,
      child: Stack(
        children: <Widget>[
          Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
              appBar: AppBar(),
              context: context,
              user: user,
              scaffoldKey: _scaffoldKey,
            ),
            drawer: CustomLeftDrawer(),
            endDrawer: CustomDrawer(),
            body: buildContainer(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: CustomFAB(),
            bottomNavigationBar: CustomBottomBar(
              scaffoldKey: _scaffoldKey,
              showPhone: toggleBackdrop,
            ),
          ),
          _isSOSActive ? Positioned(child: SOSScreen()) : SizedBox()
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: <Widget>[
            ServiceCard(
              service: services[0],
              location: userLocation,
              userId: user != null ? user.id : null,
              hasInternet: hasInternet,
              url: serverUrl != null ? serverUrl["ambulance"] : null,
              context: context,
            ),
            SizedBox(height: 10),
            ServiceCard(
              service: services[1],
              location: userLocation,
              userId: user != null ? user.id : null,
              hasInternet: hasInternet,
              url: serverUrl != null ? serverUrl["police"] : null,
              context: context,
            ),
            SizedBox(height: 10),
            ServiceCard(
              service: services[2],
              location: userLocation,
              userId: user != null ? user.id : null,
              hasInternet: hasInternet,
              url: serverUrl != null ? serverUrl["firedep"] : null,
              context: context,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
