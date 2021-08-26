import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:message/Component/LocalNotificationConfig.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  static LocalNotificationConfig notificationService =
      new LocalNotificationConfig(
    flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
  );
}
