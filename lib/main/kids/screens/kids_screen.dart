import 'package:flutter/material.dart';

//packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

//widgets
import 'package:toddily_preschool/common/widgets/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_widget.dart';

class KidsScreen extends StatelessWidget {
  static const routeName = '/kids-screen';
  bool? isComingFromClassesScreen = false;
  String? classTitle;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  KidsScreen({this.isComingFromClassesScreen, this.classTitle});

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: isComingFromClassesScreen != null ? classTitle! : 'My Kids',
          titleContainerWidth: 100.w,
          withBackButton: isComingFromClassesScreen ?? false,
        ),
        drawer: AppDrawer(),
        body: Container(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  Spacer(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Image.asset('assets/images/pens.png'),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, i) => KidsWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Column(
        //   children: [
        //     SizedBox(
        //       height: 15.h,
        //     ),
        //     // IF MORE THAN ONE KID
        //     Expanded(
        //       child: ListView.builder(
        //         physics: const ScrollPhysics(),
        //         shrinkWrap: true,
        //         itemCount: 20,
        //         itemBuilder: (context, i) => KidsWidget(),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        //       child: Image.asset('assets/images/pens.png'),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
