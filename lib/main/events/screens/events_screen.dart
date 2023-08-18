import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/widgets/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/widgets/event_widget.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';

class EventsScreen extends StatelessWidget {
  static const routeName = '/events-screen';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true ,
        drawerEdgeDragWidth: 200.w,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: 'Events',
          titleContainerWidth: 100.w,
          withBackButton: false,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(12.sp),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2.sp,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 20.w,
                ),
                itemBuilder: (context, i) => EventWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
