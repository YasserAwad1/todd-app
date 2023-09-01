import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  const PhotosScreen({
    super.key,
  });

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;
  var _photosFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photosFuture =
        Provider.of<PhotosProvider>(context, listen: false).getPhotos();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  // final String? title;
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
          title: AppLocalizations.of(context)!.latestPhotos,
          titleContainerWidth: 170.w,
          withBackButton: false,
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
            FutureBuilder(
                future: _photosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator()
                          : CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                    );
                  }
                  List<PhotoModel> photos =
                      Provider.of<PhotosProvider>(context, listen: false)
                          .photos;
                  return Expanded(
                    // PUT OPTION TO DOWNLOAD IMAGES
                    child: !isList
                        ? GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: photos.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                            ),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.1.sp,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w),
                            itemBuilder: (context, i) => ImageWidget(
                              title: '',
                              startAnimation: startAnimation,
                              index: i,
                              image: photos[i].image_url,
                              images: photos,
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.all(10.sp),
                            shrinkWrap: true,
                            itemCount: photos.length,
                            itemBuilder: (context, i) => ImageWidget(
                              title: '',
                              startAnimation: startAnimation,
                              index: i,
                              image: photos[i].image_url,
                              images: photos,
                            ),
                          ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
