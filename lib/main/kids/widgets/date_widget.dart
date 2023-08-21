import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateWidget extends StatelessWidget {
  String image;
  int index;
  bool startAnimation;

  DateWidget({
    required this.image,
    required this.index,
    required this.startAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/statuses-screen');
      },
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(
          milliseconds: 500 + (index * 100),
        ),
        transform: Matrix4.translationValues(
            startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20.sp),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.9,
                blurRadius: 10,
                offset: Offset(6, 7),
              ),
            ]),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 1,
              right: 2,
              child: SizedBox(
                height: 50.h,
                child: Image.asset(
                  image,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 7.w,
              child: SizedBox(
                height: 50.h,
                child: Image.asset(
                  'assets/images/birds.png',
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  '24',
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "LuckiestGuy",
                  ),
                ),
                Text(
                  'MAR',
                  style: TextStyle(
                    fontSize: 25.sp,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "LuckiestGuy",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
