import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  String title;
  NotificationWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
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
          title: Text(title),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
