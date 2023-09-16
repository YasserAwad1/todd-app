import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/monthly_report/screens/send_report_screen.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class CustomExpandableTile extends StatefulWidget {
  ReportModel report;
  KidModel kid;
  CustomExpandableTile({required this.report, required this.kid});

  @override
  State<CustomExpandableTile> createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.report.created_at!);
    String month = DateFormat.MMMM().format(date);

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: isExpanded ? 20.w : 0,
          vertical: 15.h,
        ),
        padding: EdgeInsets.all(20.sp),
        // height: isExpanded ? 85.h : 330.h,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1200),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isExpanded
                  ? Colors.black.withOpacity(0.5)
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: isExpanded
              ? Colors.grey[400]
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(
            Radius.circular(isExpanded ? 20 : 0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  month,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: "luckiestGuy"
                      // fontWeight: FontWeight.w400,
                      ),
                ),
                const Spacer(),
                if (Provider.of<UserProvider>(context, listen: false)
                        .getUserRoleId() ==
                    3)
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MyNavigator(
                              curves: Curves.ease,
                              screen: SendReportScreen(
                                isEditing: true,
                                kid: widget.kid,
                                previousReport: widget.report,
                              )));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 23,
                      color: Colors.red,
                    ),
                  ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 27,
                ),
              ],
            ),
            isExpanded ? const SizedBox() : SizedBox(height: 20.h),
            AnimatedCrossFade(
              firstChild: const Text(
                '',
                style: TextStyle(
                  fontSize: 0,
                ),
              ),
              secondChild: Text(
                widget.report.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.7,
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 1200),
              reverseDuration: Duration.zero,
              sizeCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ],
        ),
      ),
    );
  }
}
