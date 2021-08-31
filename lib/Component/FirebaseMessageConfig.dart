import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:message/Static/ApplicationInitSettings.dart';
import 'package:message/Static/Constants.dart';
import 'package:message/Static/LocalNotificationService.dart';

class FirebaseMessageConfig {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  static Future<void> initialize() async {
    if (!kIsWeb) {
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        int uniqueId = 0;
        String image = '';

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? apple = message.notification?.apple;

        if (notification != null && android != null && !kIsWeb) {
          print('notification.title: ${notification.title}');
          print('notification.body: ${notification.body}');
          print('android.clickAction: ${android.clickAction}');
          print('android.imageUrl: ${android.imageUrl}');
          print('android.link: ${android.link}');
          print('message.data: ${message.data}');
          print('message.sentTime: ${message.sentTime}');

          uniqueId = message.sentTime.hashCode;
          image = android.imageUrl != null ? android.imageUrl! : '';
        }
        if (notification != null && apple != null && !kIsWeb) {
          print('notification.title: ${notification.title}');
          print('notification.body: ${notification.body}');
          print('apple.imageUrl: ${apple.imageUrl}');
          print('apple.subtitle: ${apple.subtitle}');
          print('apple.badge: ${apple.badge}');

          uniqueId = message.hashCode;
          image = apple.imageUrl != null ? apple.imageUrl! : '';
        }

        LocalNotificationService.notificationService.showCustomNotification(
          uniqueId,
          notification!.title,
          notification.body,
          image,
          json.encode(message.data),
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
      });

      getToken().then(
        (value) => ApplicationInitSettings.instance.sharedPreferences.setString('token', value!),
      );
      subscribeTopic('fcm_all');
    } else {}
  }

  static Future<void> sendPushMessage(
      List<String> token,
      Map<String, dynamic> additionalData,
      Map<String, dynamic> notificationData) async {
    if (token.isEmpty) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        encoding: Encoding.getByName('utf-8'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key = ${Constants.firebaseTokenAPIFCM}',
        },
        body: constructFCMPayload(token, additionalData, notificationData),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        // on success do sth
        print('FCM request for device sent!');
      } else {
        print(' CFM error');
        // on failure do sth
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> subscribeTopic(String topicName) async {
    await firebaseMessaging.subscribeToTopic(topicName);
  }

  Future<void> unsubscribeTopic(String topicName) async {
    await firebaseMessaging.unsubscribeFromTopic(topicName);
  }

  static Future<String?> getToken() async {
    String token = '';
    print(defaultTargetPlatform);
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      print('FlutterFire Messaging: Getting APNs token...');
      token = (await firebaseMessaging.getAPNSToken())!;
      print('FlutterFire Messaging: Got APNs token: $token');
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      print('FlutterFire Messaging: Getting token...');
      token = (await firebaseMessaging.getToken())!;
      print('FlutterFire Messaging: Got token: $token');
    } else {
      print(
          'FlutterFire Messaging: Getting an APNs token is only supported on iOS and macOS platforms.');
    }
    return token;
  }

  static int _messageCount = 0;

  static String constructFCMPayload(
      List<String> token,
      Map<String, dynamic> additionalData,
      Map<String, dynamic> notificationData) {
    _messageCount++;
    return jsonEncode({
      "registration_ids": token,
      "collapse_key": "type_a",
      'data': additionalData.isEmpty
          ? {
              'via': 'FlutterFire Cloud Messaging!!!',
              'count': _messageCount.toString(),
            }
          : additionalData,
      'notification': notificationData.isEmpty
          ? {
              'title': 'Hello FlutterFire!',
              'body':
                  'This notification (#$_messageCount) was created via FCM!',
            }
          : notificationData,
    });
  }
}
