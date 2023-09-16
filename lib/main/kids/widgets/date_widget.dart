import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/main/statuses/screens/statuses_screen_for_preview.dart';

class DateWidget extends StatelessWidget {
  String image;
  int index;
  bool startAnimation;
  String sentDate;
  int childId;

  DateWidget(
      {required this.image,
      required this.index,
      required this.startAnimation,
      required this.sentDate,required this.childId,});

  @override
  Widget build(BuildContext context) {
    print('******************SENT DATE*****************');
    print(sentDate);
    print('******************SENT DATE*****************');
    DateTime date = DateTime.parse(sentDate);

    String day = date.day.toString();
    String month = date.month.toString();

    List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    String monthAbbreviation = monthAbbreviations[int.parse(month) - 1];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MyNavigator(
            screen: StatusesScreenForPreview(
              day: day,
              month: monthAbbreviation,
              date: sentDate,
              childId: childId,
            ),
            curves: Curves.fastOutSlowIn,
          ),
        );
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
                  day,
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "LuckiestGuy",
                  ),
                ),
                Text(
                  monthAbbreviation,
                  style: TextStyle(
                    fontSize: 30.sp,
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
