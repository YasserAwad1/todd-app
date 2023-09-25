import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/widgets/app_place_holder.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

class SubStatusWidgetForPreview extends StatefulWidget {
  bool startAnimation;
  int index;
  SubStatusModel subStatus;

  SubStatusWidgetForPreview({
    required this.startAnimation,
    required this.index,
    required this.subStatus,
  });
  @override
  State<SubStatusWidgetForPreview> createState() =>
      _SubStatusWidgetForPreviewState();
}

class _SubStatusWidgetForPreviewState extends State<SubStatusWidgetForPreview> {
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
          EdgeInsets.only(top: 10.sp, bottom: 10.sp, left: 14.sp, right: 3.sp),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.9,
            blurRadius: 5,
            offset: Offset(6, 7),
          ),
        ],
      ),
      width: 310.w,
      height: 220.h,
      child: Row(
        children: [
          SizedBox(
            height: 90.h,
            width: 90.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.sp),
              child: Image.network(
                '${Endpoints.baseUrl}${widget.subStatus.image}',
                fit: BoxFit.fill,
                frameBuilder: (_, image, loadingBuilder, __) {
                  if (loadingBuilder == null) {
                    return AppPlaceholder(
                        child: Container(
                      color: Colors.black,
                      height: 200.h,
                    ));
                  }
                  return image;
                },
                errorBuilder: (context, error, stackTrace) => Image(
                  image: AssetImage('images/image_error.jpg'),
                  height: 160.h,
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
              if (widget.subStatus.description == null)
                SizedBox(
                  height: 40.h,
                ),
              Flexible(
                child: Row(
                  children: [
                    Text(
                      widget.subStatus.name!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "LuckiestGuy",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              if (widget.subStatus.description != null)
                Flexible(
                  child: SizedBox(
                    width: 110.w,
                    child: Marquee(
                      text: widget.subStatus.description!,
                      velocity: 15,
                      pauseAfterRound: const Duration(
                        seconds: 3,
                      ),
                      scrollAxis: Axis.vertical,
                      blankSpace: 10.h,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
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
