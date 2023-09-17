import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';

class CustomSlimyCard extends StatelessWidget {
  String question;
  String answer;
  CustomSlimyCard({
    required this.question,
    required this.answer,
  });

  topWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontFamily: "LuckiestGuy",
          ),
        ),
      ],
    );
  }

  bottomWidget() {
    return Container(
      margin: EdgeInsets.all(10.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 10),
          Flexible(
              child: Text(
            answer,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0.sp),
      child: FlutterSlimyCard(
        color: Theme.of(context).colorScheme.secondary,
        slimeEnabled: true,
        topCardHeight: 150.h,
        bottomCardHeight: 200,
        topCardWidget: topWidget(),
        bottomCardWidget: bottomWidget(),
      ),
    );
  }
}
