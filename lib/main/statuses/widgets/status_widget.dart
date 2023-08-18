import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toddily_preschool/main/statuses/widgets/substatus_widget.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
              SizedBox(height: 4.h,),
              Text(
                'Drinks',
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
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, i) => SubstatusWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
