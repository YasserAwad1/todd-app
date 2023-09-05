import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class MonthTileWidget extends StatelessWidget {
  ReportModel report;
  MonthTileWidget({
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(report.created_at!);
    String month = DateFormat.MMMM().format(date);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.h),
      child: ExpansionTile(
        title: Text(
          month,
          style: const TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontFamily: "LuckiestGuy"
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.sp,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.sp,
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        childrenPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.topLeft,
        children: [
          Text(
            report.description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
