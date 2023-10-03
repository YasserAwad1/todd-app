import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/notifications/notification_model.dart';

class NotificationService {
  bool hasError = false;

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final url = Uri.parse(Endpoints.getNotifications);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        // print(jsonResponse);
        final notifications = (jsonResponse['notifications'] as List)
            .map(
              (e) => NotificationModel().fromJson(e),
            )
            .toList();
        hasError = false;
        return notifications;
      } else {
        hasError = true;
        throw Exception('Error in getting notifications');
      }
    } catch (e) {
      // print(e);
      hasError = true;
      rethrow;
    }
  }
}
