import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutWidget extends StatelessWidget {
  bool startAnimation;
  int index;
  bool isArabic;

  AboutWidget(
      {required this.startAnimation,
      required this.index,
      required this.isArabic});

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
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isArabic ? 0 : 100),
              bottomRight: Radius.circular(isArabic ? 0 : 100),
              topLeft: Radius.circular(isArabic ? 100 : 0),
              bottomLeft: Radius.circular(isArabic ? 100 : 0),
            ),
            // shape: BoxShape.circle,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isArabic)
                SizedBox(
                  height: 5.h,
                ),
              Text(
                AppLocalizations.of(context)!.aboutToddilyps,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontFamily: isArabic ? "Lalezar": "LuckiestGuy",
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
                      isArabic
                          ? 'لوريم ايبسوم هو نموذج افتراضي يوضع في التصاميم لتعرض على العميل ليتصور طريقه وضع النصوص بالتصاميم سواء كانت تصاميم مطبوعه ... بروشور او فلاير على سبيل المثال ... او نماذج مواقع انترنت ...'
                          : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua,Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      maxLines: isArabic ? 4 : 7,
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
          right: isArabic ? null : -43.w,
          top: 20.h,
          left: isArabic ? -43 : null,
          // left: 1,
          // left: isArabic ? -43 : 0,
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
