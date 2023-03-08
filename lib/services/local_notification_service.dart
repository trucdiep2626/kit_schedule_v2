import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static Future<ByteArrayAndroidBitmap> getImageBytes(String imageUrl) async {
    final bytes = (await rootBundle.load(imageUrl)).buffer.asUint8List();
    final androidBitMap =
        ByteArrayAndroidBitmap.fromBase64String(base64.encode(bytes));
    return androidBitMap;
  }

  static void setupNotification(
      {required String title,
      required String content,
      required DateTime scheduleDateTime,
      required int notiId,
      String? androidIconPath,
      String? payload}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    final curentTimeZone = tz.getLocation('Asia/Ho_Chi_Minh');

    final scheduleTime = tz.TZDateTime(
        curentTimeZone,
        scheduleDateTime.year,
        scheduleDateTime.month,
        scheduleDateTime.day,
        scheduleDateTime.hour,
        scheduleDateTime.minute,
        scheduleDateTime.second);

    final tzTimeSchedule = tz.TZDateTime.from(
      scheduleTime,
      curentTimeZone,
    );

    flutterLocalNotificationsPlugin.zonedSchedule(
        notiId,
        title,
        content,
        tzTimeSchedule,
        NotificationDetails(
            android: AndroidNotificationDetails(
              'class_schedule_notification',
              'Class schedule notification',
              channelDescription: 'Class schedule notification Des',
              icon: androidIconPath ?? "@mipmap/ic_launcher",
              priority: Priority.high,
              importance: Importance.max,
              largeIcon:
                  const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: "default",
            )),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    debugPrint('-------Notification Added with ID: $notiId--------');
  }

  static Future<void> cancelScheduleNotification(int notiId) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancel(notiId);
    debugPrint("-------Notification removed with ID: $notiId-------");
  }

  static Future<void> cancelAllScheduleNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint("-------All Notification removed-------");
  }

  static onDidReceiveLocalNotification(i1, s1, s2, s3) {}

  static void initNotificationLocal() async {
    tz.initializeTimeZones();

    await Permission.notification.request();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTapNotification);

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void onTapNotification(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;
    if (payload != null) {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      if (data["route"] != null) {
        Get.toNamed(data["route"] as String);
      }
    }
  }
}
