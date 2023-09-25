import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/main.dart';
import 'package:toddily_preschool/main/splash_screen/providers/splash_provider.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen_for_preview.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // WHEN IN  BACKGROUND BUT NOT OPENED
  // String? type;
  // if (type == 'normal') {
  //   navigatorKey.currentState!.pushNamed('/about-screen');
  // } else if (type == 'status') {
  //   navigatorKey.currentState!.pushNamed('/FAQ-screen');
  // }
  print(
      '*********************************THIS IS HANDING BACKGROUND******************************************************');
  BuildContext context = navigatorKey.currentState!.context;
  Provider.of<SplashProvider>(context, listen: false).setNotification();
  Provider.of<SplashProvider>(context, listen: false).setMessage(message);
}

void handleMessage(RemoteMessage? message) {
  // INSIDE APPLICAION
  String? type;
  print(
      '*********************************THIS IS HANDlING MESSAGE******************************************************');
  if (message == null) {
    return;
  } else {
    // BuildContext context = navigatorKey.currentState!.context;
    // Provider.of<SplashProvider>(context, listen: false).setNotification();
    // Provider.of<SplashProvider>(context, listen: false).setMessage(message);
    type = message.data['type'];
    if (type == 'normal') {
      navigatorKey.currentState!.pushNamed('/notifications-screen');
    } else if (type == 'status') {
      var decoded = jsonDecode(message.data['body']);
      var kid = KidModel.fromJson(decoded['child']);
      var sentDate = decoded['date'];
      DateTime date = DateTime.parse(sentDate);
      String day = date.day.toString();
      String month = date.month.toString();
      List<String> monthAbbreviations = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      String monthAbbreviation = monthAbbreviations[int.parse(month) - 1];
      Navigator.push(
          navigatorKey.currentState!.context,
          MyNavigator(
            screen: StatusesScreenForPreview(
              childId: kid.id,
              date: date.toString(),
              day: day,
              month: monthAbbreviation,
            ),
            curves: Curves.ease,
          ));
    }
  }
}

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static const _androidChannel = AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.max);
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
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      print('THIS IS THE INITIAL MESSAGE ');
      await handleBackgroundMessage(message!); // app opened in a notification
    });
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
    await locator.get<LocalRepo>().saveDeviceToken(fCMToken!);
    print('token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}
