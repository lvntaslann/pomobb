import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const String dailyNotificationTask = "dailyNotificationTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {


    tz.initializeTimeZones();
    try {
      final String tzString = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzString));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Istanbul'));
    }

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);

    const androidDetails = AndroidNotificationDetails(
      'workmanager_channel',
      'WorkManager Notifications',
      channelDescription: 'Background notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      inputData?['title'] ?? 'Pomobb Background',
      inputData?['body'] ?? 'Uygulama kapalıyken bildirim!',
      notificationDetails,
    );

    return Future.value(true);
  });
}

