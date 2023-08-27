import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTile extends StatelessWidget {
  String title;
  String? subtitle;
  String? image;
  IconData? icon;
  VoidCallback? function;

  CustomTile({
    required this.title,
    this.image,
    this.icon,
    this.subtitle,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      elevation: 5,
      shadowColor: Colors.black,
      child: ListTile(
        contentPadding: EdgeInsets.all(7.sp),
        leading: icon != null
            ? Icon(
                icon!,
                size: 35.sp,
                color: Theme.of(context).colorScheme.secondary,
              )
            : Image.asset(
              image!,
            ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: "LuckiestGuy",
          ),
        ),
        // isThreeLine: true,
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
            : null,
        onTap: function,
      ),
    );
  }
}
