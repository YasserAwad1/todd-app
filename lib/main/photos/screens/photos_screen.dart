import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/photos/providers/photos_povider.dart';
import 'package:toddily_preschool/main/photos/widgets/image_widget.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';

class PhotosScreen extends StatefulWidget {
  static const routeName = '/photos-screen';
  const PhotosScreen({
    super.key,
  });

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;
  var _photosFuture;
  bool expanded = true;
  AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photosFuture = Provider.of<PhotosProvider>(context, listen: false)
        .getPhotos()
        .then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  Future<void> _refreshData() async {
    await Provider.of<PhotosProvider>(context, listen: false).getPhotos();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isList = Provider.of<PhotosProvider>(context, listen: false).isList;

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            isList ? controller!.forward() : controller!.reverse();
            setState(() {
              Provider.of<PhotosProvider>(context, listen: false)
                  .changeListGridView();
            });
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.view_list,
            progress: controller!,
          ),
        ),
        body: LiquidPullToRefresh(
          onRefresh: () {
            return _refreshData();
          },
          animSpeedFactor: 4,
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              FutureBuilder(
                  future: _photosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return RippleWidget();
                    }
                    if (Provider.of<PhotosProvider>(context, listen: false)
                        .hasError) {
                      return CustomErrorWidget();
                    }
                    List<PhotoModel> photos =
                        Provider.of<PhotosProvider>(context, listen: false)
                            .photos;
                    if (photos.isEmpty) {
                      return NoInformationWidget();
                    }
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
      ),
    );
  }
}
