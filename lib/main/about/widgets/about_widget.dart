import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutWidget extends StatelessWidget {
  bool startAnimation;
  int index;
  AboutWidget({
    required this.startAnimation,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          curve: Curves.linear,
          duration: Duration(
            milliseconds: 500 + (index * 100),
          ),
          transform: Matrix4.translationValues(
              startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
          padding: EdgeInsets.all(7.sp),
          height: 170.h,
          width: 320.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.9,
                blurRadius: 10,
                offset: Offset(6, 7),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            // shape: BoxShape.circle,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                'About Toddily Preschool',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontFamily: "LuckiestGuy",
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 280.w,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua,Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      maxLines: 7,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: -43.w,
          top: 20.h,
          child: AnimatedContainer(
            curve: Curves.easeOutSine,
            duration: Duration(
              milliseconds: 500 + (index * 100),
            ),
            transform: Matrix4.translationValues(
              startAnimation
                  ? 0
                  : MediaQuery.of(context).size.width, // X translation
              startAnimation
                  ? 0
                  : -MediaQuery.of(context)
                      .size
                      .height, // Y translation (negative value to move down)
              0,
            ),
            // width: 70.w,
            // height: 70.h,
            child: Image.asset(
              'assets/images/characters/astro2.png',
              fit: BoxFit.contain,
              scale: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}
