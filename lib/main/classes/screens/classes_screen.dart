import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/classes/providers/class_provider.dart';
import 'package:toddily_preschool/main/classes/widgets/class_widget.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/statuses/providers/status_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClassesScreen extends StatefulWidget {
  static const routeName = '/classes-screen';

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;
  var _classesFuture;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classesFuture = Provider.of<ClassProvider>(context, listen: false)
        .getClasses()
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<ClassProvider>(context, listen: false).getClasses();

    setState(() {
      isLoading = false;
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
          title: AppLocalizations.of(context)!.classes,
          titleContainerWidth: 100.w,
          withBackButton: false,
          stayEnglish: true,
        ),
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        body: RefreshIndicator(
          onRefresh: () {
            return _refreshData();
          },
          child: Container(
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
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          isLoading) {
                        return RippleWidget(
                          height: 0,
                        );
                      } else if (Provider.of<ClassProvider>(context,
                              listen: false)
                          .hasError) {
                        return CustomErrorWidget(
                          height: 0,
                        );
                      } else {
                        var classes =
                            Provider.of<ClassProvider>(context, listen: false)
                                .classes;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: classes.length,
                          itemBuilder: (context, i) => ClassWidget(
                            startAnimation: startAnimation,
                            index: i,
                            classModel: classes[i],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
