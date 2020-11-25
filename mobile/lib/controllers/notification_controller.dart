import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:SOS_Brasil/main.dart';

class NotificationController {
  static void showSendNotification() async {
    await _sendNotification();
  }

  static void showStatusNotification(String status) async {
    if (status == "accepted") {
      await _acceptedNotification();
    } else {
      await _deniedNotification();
    }
  }

  static Future<void> cancellAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> cancel(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> _deniedNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "channel_ID", "channel name", "channel description",
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        ticker: "Requisição aceita",
        enableVibration: true,
        playSound: true,
        color: Colors.red[400]);

    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
        0, "Aguardando confirmação...", "", platformChannelSpecifics,
        payload: "test");
  }

  static Future<void> _acceptedNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "channel_ID", "channel name", "channel description",
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        ticker: "Requisição aceita",
        enableVibration: true,
        playSound: true,
        color: Colors.red[400]);

    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
        0, "Aguardando confirmação...", "", platformChannelSpecifics,
        payload: "test");
  }

  static Future<void> _sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "channel_ID", "channel name", "channel description",
        importance: Importance.max,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        ticker: "Aguardando confirmação",
        enableVibration: true,
        playSound: true,
        autoCancel: false,
        ongoing: true,
        showProgress: true,
        indeterminate: true,
        color: Colors.red[400]);

    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
        0, "Aguardando confirmação...", "", platformChannelSpecifics,
        payload: "test");
  }
}
