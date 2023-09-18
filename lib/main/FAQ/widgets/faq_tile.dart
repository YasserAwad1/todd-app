import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';

class QATile extends StatelessWidget {
  String question;
  String answer;

  QATile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.h),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontFamily: "LuckiestGuy"),
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
            answer,
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
