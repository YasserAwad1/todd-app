import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatesScreenButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback function;
  DatesScreenButton({
    required this.title,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.9),
        ),
        onPressed: function,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 27.sp,
        ),
        label: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 18.sp),
        ),
      ),
    );
  }
}
