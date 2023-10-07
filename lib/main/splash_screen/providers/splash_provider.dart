import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toddily_preschool/main/notifications/screens/notifications_screen.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen_for_preview.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';

class SplashProvider with ChangeNotifier {
  bool isNotification = false;
  RemoteMessage? message;

  setNotification() {
    isNotification = true;
    notifyListeners();
  }

  //MYTODO
  //SET ISNOTIFICATION TO FALSE WHERE YOU FIND IT GOOD


  setMessage(RemoteMessage msg) {
    message = msg;
    // notifyListeners();
  }

  Widget handleNotification() {
    // print('THIS IS HANDLE NOTIFICATIONSSSSSSSSSSSSSSSSSSSSSSSSS');
    String type = message!.data['type'];
    if (type == 'normal') {
      return NotificationsScreen();
    } else {
      var decoded = jsonDecode(message!.data['body']);
      // print('************************NOTIFICATION RESPONSE******************');
      // print(decoded);
      // print('************************NOTIFICATION RESPONSE******************');
      var kid = KidModel.fromJson(decoded['child']);
      var sentDate = decoded['date'];
      DateTime date = DateTime.parse(sentDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      // print('**********************DATE TO STATUSES SCREEN************************');
      // print(formattedDate);
      // print(kid.id);
      // print('**********************DATE TO STATUSES SCREEN************************');
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
      return StatusesScreenForPreview(
        childId: kid.id,
        date: formattedDate,
        day: day,
        month: monthAbbreviation,
      );
    }
  }
}
