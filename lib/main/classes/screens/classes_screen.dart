import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/main/classes/widgets/class_widget.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';

class ClassesScreen extends StatefulWidget {
  static const routeName = '/classes-screen';

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: 'classes',
          titleContainerWidth: 100.w,
          withBackButton: false,
        ),
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        body: Container(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Image.asset('assets/images/kids.png'),
                  ),
                ],
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, i) => ClassWidget(
                  startAnimation: startAnimation,
                  index: i,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
