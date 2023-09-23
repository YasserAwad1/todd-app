import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/notifications/service/notification_service.dart';
import 'package:toddily_preschool/models/notifications/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  NotificationService service = NotificationService();
  List<NotificationModel> notifications = [];
  bool hasError = false;

  getNotifications() async {
    try {
      notifications = await service.getNotifications();
      hasError = service.hasError;
    } catch (e) {
      hasError = service.hasError;
      rethrow;
    }
  }
}
