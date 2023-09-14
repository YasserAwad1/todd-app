import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/my_navigator.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/kids/screens/dates_screen.dart';
import 'package:toddily_preschool/main/monthly_report/screens/monthly_report_screen.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/social_media_expert/screens/camera_screen.dart';
import 'package:toddily_preschool/social_media_expert/screens/pick_image_screen.dart';

class KidsWidget extends StatelessWidget {
  bool startAnimation;
  int index;
  KidModel kid;
  String classTitle;

  KidsWidget({
    required this.startAnimation,
    required this.index,
    required this.kid,
    required this.classTitle,
  });

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///IF KID DIDNT HAVE PHOTO CHOOSE PHOTO
  ////
  ///
  ///
  ///
  ///
  ///
  ///////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();
    print(kid.image);

    return GestureDetector(
      onTap: () {
        Provider.of<UserProvider>(context, listen: false).forDatesScreen()
            ? Navigator.push(
                context,
                MyNavigator(
                    screen: DatesScreen(
                      kid: kid,
                    ),
                    curves: Curves.easeOutBack),
              )
            : Provider.of<UserProvider>(context, listen: false)
                        .getUserRoleId() ==
                    4
                ? Navigator.push(
                    context,
                    MyNavigator(
                      curves: Curves.ease,
                      screen: PickImageScreen(
                        kid: kid,
                      ),
                    ),
                  )
                : Navigator.push(
                    context,
                    MyNavigator(
                      screen: MonthlyReportScreen(kid: kid),
                      curves: Curves.easeInOutQuart,
                    ),
                  );
      },
      child: Center(
        child: AnimatedContainer(
          curve: Curves.easeOutSine,
          duration: Duration(
            milliseconds: 500 + (index * 100),
          ),
          transform: Matrix4.translationValues(
              startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
          padding: EdgeInsets.all(15.sp),
          margin: EdgeInsets.all(15.sp),
          width: 300.w,
          // height: 130.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15.sp,
              ),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(6, 10),
                ),
              ]),
          child: Row(
            children: [
              SizedBox(
                height: 90.h,
                width: 90.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.sp),
                  child: Image.network(
                    '${Endpoints.baseUrl}${kid.image}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RESOLVE TEXT FIT PROBLEM
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      kid.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    classTitle,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (kid.isExtra == 1)
                    Container(
                      height: 30.h,
                      width: 80.w,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red),
                      child: Text(
                        'Extra',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "luckiestGuy",
                            color: Colors.white,
                            fontSize: 16.sp),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 35.w,
              ),
              Icon(
                isArabic
                    ? Icons.arrow_circle_left_outlined
                    : Icons.arrow_circle_right_outlined,
                color: Colors.white,
                size: 35.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
