import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/widgets/event_image_widget.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/photos/widgets/list_grid_buttons.dart';
import 'package:toddily_preschool/models/events/event_model.dart';

class EventPhotosScreen extends StatefulWidget {
  static const routeName = '/event-photos-screen';
  EventModel? event;
  EventPhotosScreen({
    this.event,
  });

  @override
  State<EventPhotosScreen> createState() => _EventPhotosScreenState();
}

class _EventPhotosScreenState extends State<EventPhotosScreen> {
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
    bool isList = Provider.of<PhotosProvider>(context).isList;
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: 200.w,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          title: widget.event!.name,
          titleContainerWidth: 170.w,
          withBackButton: true,
          stayEnglish: true,
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
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.event!.event_images.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1.sp,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w),
                      itemBuilder: (context, i) => EventImageWidget(
                        image: widget.event!.event_images[i].src,
                        index: i,
                        startAnimation: startAnimation,
                        eventName: widget.event!.name,
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.sp),
                      shrinkWrap: true,
                      itemCount: widget.event!.event_images.length,
                      itemBuilder: (context, i) => EventImageWidget(
                        image: widget.event!.event_images[i].src,
                        index: i,
                        eventName: widget.event!.name,
                        startAnimation: startAnimation,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
