import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:toddily_preschool/common/widgets/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/photos/widgets/image_widget.dart';
import 'package:toddily_preschool/main/photos/widgets/list_grid_buttons.dart';

class PhotosScreen extends StatefulWidget {
  static const routeName = '/photos-screen';

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
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

  // final String? title;
  @override
  Widget build(BuildContext context) {
    bool isPhotosScreen = Provider.of<PhotosProvider>(context).isPhotosScreen;
    bool isList = Provider.of<PhotosProvider>(context).isList;
    String eventName = Provider.of<EventProvider>(context).getEventNameById();

    //////EVENT TITLE HERE IS CAUSING A PROBLEM //////
    ///I RESOLVED THE PROBLEM USING PROVIDER BUT I WANT TO WAIT FOR THE BACKEND TO SEE IF THE
    ///PROBLEM IS STILL THERE///

    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: isPhotosScreen ? true : false,
        drawerEdgeDragWidth: 200.w,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: isPhotosScreen ? 'Latest Photos' : eventName,
          titleContainerWidth: 150.w,
          withBackButton: isPhotosScreen ? false : true,
          withNotification: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            ListGridButtons(isList: isList),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              // PUT OPTION TO DOWNLOAD IMAGES
              child: !isList
                  ? GridView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: 8,
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1.sp,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w),
                      itemBuilder: (context, i) => ImageWidget(
                        title: eventName,
                        startAnimation: startAnimation,
                        index: i,
                      ),
                    )
                  : ListView.builder(
                    physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.sp),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, i) => ImageWidget(
                        title: eventName,
                        startAnimation: startAnimation,
                        index: i,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
