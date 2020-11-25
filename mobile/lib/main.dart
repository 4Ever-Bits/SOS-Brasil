import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:SOS_Brasil/screens/CallTrackingScreen/call_tracking_screen.dart';
import 'package:SOS_Brasil/screens/LandingScreen/landing_screen.dart';
import 'package:SOS_Brasil/screens/ForgotPasswordScreen/fp_emailsend.dart';
import 'package:SOS_Brasil/screens/HomeScreen/home_screen.dart';
import 'package:SOS_Brasil/screens/InfoScreen/info_screen.dart';
import 'package:SOS_Brasil/screens/MapScreen/map_screen.dart';
import 'package:permission_handler/permission_handler.dart';

// Create storage
final storage = new FlutterSecureStorage();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

var initializationSettingsAndroid = AndroidInitializationSettings("app_icon");
var initializationSettingsIOS = IOSInitializationSettings(
  requestAlertPermission: true,
  requestBadgePermission: true,
  requestSoundPermission: true,
  onDidReceiveLocalNotification: (id, title, body, payload) async {},
);
var initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    },
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    storage.read(key: "user").then((value) {
      Widget initWidget = value != null ? HomePage() : LandingScreen();

      runApp(MaterialApp(
        title: "SOS Brasil",
        routes: {
          "/": (context) => initWidget,
          "/home": (context) => HomePage(),
          "/start": (context) => LandingScreen(),
          "/info": (context) => InfoScreen(),
          "/forgotpassword": (context) => ForgotPasswordScreen(),
          "/maps": (context) => MapScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red[400],
          accentColor: Colors.red,
          scaffoldBackgroundColor: Colors.grey[300],
          canvasColor: Colors.transparent,
          fontFamily: "Roboto",
        ),
      ));
    });
  });
}
