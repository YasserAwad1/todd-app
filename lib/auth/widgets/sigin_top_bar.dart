import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninTopBar extends StatelessWidget {
  bool isArabic;
  SigninTopBar({
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.sp),
              width: 200.w,
              height: 130.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(isArabic ? 0 : 50),
                    bottomLeft: Radius.circular(isArabic ? 50 : 0)
                  ),
                  color: Theme.of(context).colorScheme.secondary),
              child: Image.asset('assets/images/ToddilyLogo.png'),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        SizedBox(
          height: 130.h,
          width: 100.w,
          child: Image.asset(
            'assets/images/characters/astro3.png',
          ),
        )
      ],
    );
  }
}
