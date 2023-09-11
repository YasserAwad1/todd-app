import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toddily_preschool/main/statuses/statusesToSend/widgets/substatus_widget_to_send.dart';
import 'package:toddily_preschool/models/status/status_model.dart';

class StatusWidgetToSend extends StatelessWidget {
  bool startAnimation;
  int index;
  StatusModel status;

  StatusWidgetToSend(
      {required this.startAnimation,
      required this.index,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          curve: Curves.easeOutSine,
          duration: Duration(
            milliseconds: 500 + (index * 100),
          ),
          transform: Matrix4.translationValues(
              startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
                // topRight: isArabic ? Radius.zero : Radius.circular(10.sp.sp),
                // bottomRight: isArabic ? Radius.zero : Radius.circular(10.sp.sp),
                // topLeft: isArabic ? Radius.circular(10.sp.sp) : Radius.zero,
                // bottomLeft: isArabic ? Radius.circular(10.sp.sp) : Radius.zero,
                bottomRight: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp)),
          ),
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                status.name!,
                // textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "LuckiestGuy",
                  fontSize: 20.sp,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: 155.h, //155
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: status.substatus!.length,
                itemBuilder: (context, i) => SubstatusWidgetToSend(
                      startAnimation: startAnimation,
                      index: index,
                      subStatus: status.substatus![i],
                    )),
          ),
        ),
      ],
    );
  }
}
