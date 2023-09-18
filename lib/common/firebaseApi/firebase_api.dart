import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toddily_preschool/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print(message.notification!.title);
  print(message.notification!.body);
  print(message.data);
}

void handleMessage(RemoteMessage? message) {
  if (message == null) {
    return;
  } else {
    // final FlutterLocalNotificationsPlugin notificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // notificationsPlugin.show(
    //     1,
    //     message.notification!.title,
    //     message.notification!.body,
    //     NotificationDetails(
    //         android: AndroidNotificationDetails('channelId', 'channelName',
    //             importance: Importance.max),
    //         iOS: DarwinNotificationDetails()));
    navigatorKey.currentState!.pushNamed('/about-screen');
  }
}

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static const _androidChannel = AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.defaultImportance);
  static final _localnotifications = FlutterLocalNotificationsPlugin();

  static Future initLocalNotifications() async {
    // const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/tod_logo');
    var iOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var settings = InitializationSettings(android: android, iOS: iOS);

    await _localnotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    }, onDidReceiveBackgroundNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
    final platfrom = _localnotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platfrom!.createNotificationChannel(_androidChannel);
  }

  static Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(handleMessage); // app opened in a notification
    FirebaseMessaging.onMessageOpenedApp
        .listen(handleMessage); // app opened in background state
    FirebaseMessaging.onBackgroundMessage(
        handleBackgroundMessage); // handle msh when in background
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) {
        return;
      } else {
        _localnotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/tod_logo',
              ),
              iOS: DarwinNotificationDetails()),
          payload: jsonEncode(
            message.toMap(),
          ),
        );
      }
    });
  }

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}
