import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/classes/providers/class_provider.dart';
import 'package:toddily_preschool/main/classes/widgets/class_widget.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:toddily_preschool/models/classes/class_model.dart';

class ClassesScreen extends StatefulWidget {
  static const routeName = '/classes-screen';

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;
  var _classesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classesFuture =
        Provider.of<ClassProvider>(context, listen: false).getClasses();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var yellow = Theme.of(context).colorScheme.secondary;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Provider.of<PhotosProvider>(context, listen: false)
                .getPhotos();
          },
        ),
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
              FutureBuilder(
                  future: _classesFuture,
                  builder: (context, snapshot) {
                    var classes =
                        Provider.of<ClassProvider>(context, listen: false)
                            .classes;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: yellow,
                              )
                            : CupertinoActivityIndicator(
                                color: yellow,
                              ),
                      );
                    }
                    return ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: classes.length,
                      itemBuilder: (context, i) => ClassWidget(
                        startAnimation: startAnimation,
                        index: i,
                        classModel: classes[i],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
