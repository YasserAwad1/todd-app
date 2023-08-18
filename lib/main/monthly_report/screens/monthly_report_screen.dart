import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/monthly_report/widgets/month_tile_widget.dart';

class MonthlyReportScreen extends StatelessWidget {
  static const routeName = '/monthly-report-screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            scaffoldKey: null,
            title: 'Monthly Report',
            titleContainerWidth: 180.w,
            withBackButton: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, i) => MonthTileWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
