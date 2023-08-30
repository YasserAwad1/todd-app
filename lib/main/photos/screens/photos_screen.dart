import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/photos/widgets/image_widget.dart';
import 'package:toddily_preschool/main/photos/widgets/list_grid_buttons.dart';
import 'package:toddily_preschool/models/events/event_model.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';

class PhotosScreen extends StatefulWidget {
  static const routeName = '/photos-screen';
  EventModel? event;
  List<PhotoModel>? latestPhotos;
  PhotosScreen({this.event, this.latestPhotos});

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
    // String eventName = Provider.of<EventProvider>(context).getEventNameById();

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
          title: isPhotosScreen
              ? AppLocalizations.of(context)!.latestPhotos
              : widget.event!.name,
          titleContainerWidth: 170.w,
          withBackButton: isPhotosScreen ? false : true,
          stayEnglish: isPhotosScreen ? true : false,
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
                      itemCount: isPhotosScreen
                          ? widget.latestPhotos!.length
                          : widget.event!.event_images.length,
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
                        title: isPhotosScreen ? '' : widget.event!.name,
                        startAnimation: startAnimation,
                        index: i,
                        eventImages: widget.event!.event_images,
                        eventImage: widget.event!.event_images[i],
                        isPhotosScreen: isPhotosScreen,
                        latestSinglePhoto: widget.latestPhotos![i],
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10.sp),
                      shrinkWrap: true,
                      itemCount: isPhotosScreen
                          ? widget.latestPhotos!.length
                          : widget.event!.event_images.length,
                      itemBuilder: (context, i) => ImageWidget(
                        title: isPhotosScreen ? '' : widget.event!.name,
                        startAnimation: startAnimation,
                        index: i,
                        eventImages: isPhotosScreen ? [] : widget.event!.event_images,
                        eventImage: isPhotosScreen ? null : widget.event!.event_images[i],
                        isPhotosScreen: isPhotosScreen,
                        latestSinglePhoto: widget.latestPhotos![i],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
