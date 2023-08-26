import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/my_navigator.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/kids/screens/dates_screen.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';

class KidsWidget extends StatelessWidget {
  bool startAnimation;
  int index;
  KidsWidget({
    required this.startAnimation,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<EventProvider>(context, listen: false).getRole != 2
            ? Navigator.push(
                context,
                MyNavigator(screen: DatesScreen(), curves: Curves.easeOutBack),
              )
            : Navigator.of(context).pushNamed('/camera-screen');
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
          height: 130.h,
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
                  child: Image.asset(
                    'assets/images/avatar2.jpg',
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
                      'Fateh Jamal Al Deen ',
                      overflow: TextOverflow.ellipsis,
                      // textAlign: TextAlign.justify,
                      // softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Child Class',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '1 unread status',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 35.w,
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
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
