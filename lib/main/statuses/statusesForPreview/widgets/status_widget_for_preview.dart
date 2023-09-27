import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/models/status/status_model.dart';
import 'substatus_widget_for_preview.dart';

class StatuswidgetForPreview extends StatelessWidget {
  bool startAnimation;
  int index;
  StatusModel status;

  StatuswidgetForPreview(
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
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "LuckiestGuy",
                  fontSize: 20.sp,
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
              itemBuilder: (context, i) => SubStatusWidgetForPreview(
                startAnimation: startAnimation,
                index: i,
                subStatus: status.substatus![i],
              ),
            ),
          ),
        ),
      ],
    );
  }
}