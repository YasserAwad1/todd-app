import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/widgets/app_place_holder.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

class SubstatusWidgetToSend extends StatefulWidget {
  bool startAnimation;
  int index;
  SubStatusModel subStatus;

  SubstatusWidgetToSend({
    required this.startAnimation,
    required this.index,
    required this.subStatus,
  });
  @override
  State<SubstatusWidgetToSend> createState() => _SubstatusWidgetToSendState();
}

class _SubstatusWidgetToSendState extends State<SubstatusWidgetToSend> {
  selectStatus() {
    if (!Provider.of<StatusProvider>(context, listen: false)
        .isSubstatusInList(widget.subStatus.id!)) {
      Provider.of<StatusProvider>(context, listen: false)
          .addSubStatusFromScreen(widget.subStatus);
    } else {
      Provider.of<StatusProvider>(context, listen: false)
          .removeSubStatusFromScreen(widget.subStatus);
    }
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
          EdgeInsets.only(top: 10.sp, bottom: 10.sp, left: 14.sp, right: 3.sp),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: Provider.of<StatusProvider>(context, listen: false)
                .isSubstatusInList(widget.subStatus.id!)
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
      width: 310.w,
      // height: 180.h,
      child: Row(
        children: [
          SizedBox(
            height: 90.h,
            width: 90.w,
            child: GestureDetector(
              onTap: () {
                selectStatus();
              },
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
                    image: AssetImage('assets/images/errorImage.png'),
                    height: 160.h,
                  ),
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
              Flexible(
                child: Text(
                  widget.subStatus.name!,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontFamily: "LuckiestGuy",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 150.w,
                height: 100.h,
                child: SizedBox(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        widget.subStatus.description = value;
                      }
                    },
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'description',
                    ),
                    maxLines: 5,
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
