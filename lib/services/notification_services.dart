/*import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/models/task.dart';
import '/ui/pages/notification_screen.dart';

class NotifyHelper {
  NotifyHelper();

  final localNotificationsService = FlutterLocalNotificationsPlugin();
  BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();
  intialize() async {
    tz.initializeTimeZones();
    _configureLocalTimeZone();

    const AndroidInitializationSettings androidIntializeSettings =
        AndroidInitializationSettings('appicon');

    DarwinInitializationSettings darwinIntializeSettings =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final settings = InitializationSettings(
        android: androidIntializeSettings, iOS: darwinIntializeSettings);

    await localNotificationsService.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'channelDescription',
            importance: Importance.max,
            priority: Priority.max,
            icon: 'appicon');

    const darwinNotificatiionDetails = DarwinNotificationDetails();

    return NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificatiionDetails);
  }

  showNotifications(
      {required int id, required String title, required String note}) async {
    var details = await notificationDetails();
    await localNotificationsService.show(id, title, note, details);
  }

  scheduledNotifications(
      {required int id,
      required String title,
      required String note,
      required int hour,
      required int minutes,
      required Task task}) async {
    var details = await notificationDetails();
    await localNotificationsService.zonedSchedule(
        id, title, note, _nextInstanceOfTenAM(hour, minutes), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: '${task.title}|${task.note}|${task.startTime}');
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(payload));
  }

  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

 /* Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }*/

  cancelNotification(Task task) async {
    await localNotificationsService.cancel(task.id!);
  }
}
*/