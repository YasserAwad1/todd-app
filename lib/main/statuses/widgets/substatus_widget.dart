import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';

class SubstatusWidget extends StatefulWidget {
  bool startAnimation;
  int index;

  SubstatusWidget({
    required this.startAnimation,
    required this.index,
  });
  @override
  State<SubstatusWidget> createState() => _SubstatusWidgetState();
}

class _SubstatusWidgetState extends State<SubstatusWidget> {
  bool isSelected = false;

  selectStatus() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: Duration(
        milliseconds: 500 + (widget.index * 100),
      ),
      transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
      padding:
          EdgeInsets.only(top: 10.sp, bottom: 10.sp, left: 10.sp, right: 3.sp),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: Provider.of<UserProvider>(context).roleId == 2
            ? Theme.of(context).colorScheme.secondary
            : isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.9,
            blurRadius: 5,
            offset: Offset(6, 7),
          ),
        ],
      ),
      width: 280.w,
      height: 220.h,
      child: Row(
        children: [
          SizedBox(
            height: 130.h,
            width: 110.w,
            child: GestureDetector(
              onTap: () {
                selectStatus();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.sp),
                child: Image.asset(
                  'assets/images/water.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //IF DESCRIPTION IN EMPTY PT SIZED BOX
              // SizedBox(height: 35.h,),
              Flexible(
                child: SizedBox(
                  width: 110.w,
                  child: Row(
                    children: [
                      Text(
                        'Water',
                        //IF DESCRIPTION IS EMPTY CENTER TEXT
                        // textAlign: TextAlign.center,
                        // softWrap: true,
                        // maxLines: 2,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "LuckiestGuy",
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Flexible(
                child: SizedBox(
                  width: 110.w,
                  child: Provider.of<UserProvider>(context).roleId == 5
                      ? Marquee(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          // maxLines: 5,
                          velocity: 15,
                          pauseAfterRound: Duration(
                            seconds: 3,
                          ),
                          // accelerationDuration: Duration(seconds: 20),
                          scrollAxis: Axis.vertical,
                          blankSpace: 10.h,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            // fontFamily: "LuckiestGuy",
                            // fontWeight: FontWeight.w400,
                          ),
                        )
                      : const SizedBox(
                          height: double.infinity,
                          child: TextField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white),
                              hintText: 'Description',
                            ),
                            maxLines: 10,
                            // expands: true,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 35.w,
          ),
        ],
      ),
    );
  }
}
