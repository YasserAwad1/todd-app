import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toddily_preschool/models/notifications/notification_model.dart';

class NotificationWidget extends StatelessWidget {
  NotificationModel notification;
  NotificationWidget({
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(notification.time!);
    String formattedDateTime =
        DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
          leading: Icon(
            Icons.notifications,
            color: Theme.of(context).colorScheme.secondary,
            size: 45.sp,
          ),
          title: Text(notification.body!),
          subtitle: Text(formattedDateTime),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
