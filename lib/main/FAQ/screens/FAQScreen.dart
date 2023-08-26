import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/widgets/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/monthly_report/widgets/month_tile_widget.dart';

class FAQScreen extends StatelessWidget {
  static const routeName = '/FAQ-screen';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: 'FAQs',
          titleContainerWidth: 150.w,
          withBackButton: false,
          withNotification: true,
        ),
        drawerEdgeDragWidth: 200.w,
        drawerEnableOpenDragGesture: true,
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
