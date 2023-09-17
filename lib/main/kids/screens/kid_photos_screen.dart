import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/kids/screens/kid_image_list_screen.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_image_widget.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/social_media_expert/providers/kid_image_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KidPhotosScreen extends StatefulWidget {
  KidModel? kid;
  BuildContext dateScreenViewContext;
  // GlobalKey<ScaffoldState> scaffoldKey;
  KidPhotosScreen({required this.kid, required this.dateScreenViewContext
      // required this.scaffoldKey,
      });

  @override
  State<KidPhotosScreen> createState() => _KidPhotosScreenState();
}

class _KidPhotosScreenState extends State<KidPhotosScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool startAnimation = false;
  var _kidPhotosForTeacherToCheckFuture;
  var _kidPhotosForParents;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Provider.of<UserProvider>(context, listen: false).getUserRoleId() ==
        2) {
      _kidPhotosForTeacherToCheckFuture =
          Provider.of<KidImageProvider>(context, listen: false)
              .getKidImagesToCheck(widget.kid!.id!);
    } else {
      _kidPhotosForParents =
          Provider.of<KidImageProvider>(context, listen: false)
              .getChildImagesForParents(widget.kid!.id!);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  Future<void> refreshData() async {
    print('refreshing');
    await Provider.of<KidImageProvider>(context, listen: false)
        .getKidImagesToCheck(widget.kid!.id!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          children: [
            isLoading
                ? RippleWidget()
                : Provider.of<UserProvider>(context, listen: false)
                            .getUserRoleId() ==
                        2
                    ? FutureBuilder(
                        future: _kidPhotosForTeacherToCheckFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              isLoading) {
                            return RippleWidget();
                          }
                          if (Provider.of<KidImageProvider>(context,
                                  listen: false)
                              .hasError) {
                            return CustomErrorWidget();
                          }
                          // refreshData();
                          List<KidImageModel> photos =
                              Provider.of<KidImageProvider>(context,
                                      listen: false)
                                  .kidPhotosToCheck;
                          if (photos.isEmpty) {
                            return const NoInformationWidget();
                          }
                          return Expanded(
                            // PUT OPTION TO DOWNLOAD IMAGES
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.all(10.sp),
                                shrinkWrap: true,
                                itemCount: photos.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.w,
                                        mainAxisSpacing: 10.h),
                                itemBuilder: (context, i) {
                                  return newImageWidget(context, photos, i,
                                      isArabic, widget.dateScreenViewContext);
                                }),
                          );
                        })
                    : FutureBuilder(
                        future: _kidPhotosForParents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return RippleWidget();
                          }
                          if (Provider.of<KidImageProvider>(context,
                                  listen: false)
                              .hasError) {
                            return CustomErrorWidget();
                          } else {
                            List<KidImageModel> photos =
                                Provider.of<KidImageProvider>(context,
                                        listen: false)
                                    .kidPhotosForParents;
                            if (photos.isEmpty) {
                              return const NoInformationWidget();
                            } else {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: photos.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return KidImageWidget(
                                      startAnimation: startAnimation,
                                      index: i,
                                      image: photos[i].image!,
                                      images: photos);
                                },
                              );
                            }
                          }
                        },
                      ),
          ],
        ),
      ),
    );
  }

  Padding newImageWidget(BuildContext ctx, List<KidImageModel> photos, int i,
      bool isArabic, BuildContext datesScreenCtx) {
    return Padding(
      padding: EdgeInsets.only(top: 8.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KidImageListScreen(
                images: photos,
                sentIndex: i,
                title: widget.kid!.name,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          curve: Curves.easeOutSine,
          duration: Duration(
            milliseconds: 500 + (i * 100),
          ),
          transform: Matrix4.translationValues(
              startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.sp),
                child: Image.network(
                  '${Endpoints.baseUrl}${photos[i].image}',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 0,
                right: isArabic ? null : 0,
                left: isArabic ? 0 : null,
                child: CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.3),
                  maxRadius: 20.sp,
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool success = await Provider.of<KidImageProvider>(
                              context,
                              listen: false)
                          .checkImage(photos[i].id!);

                      if (success) {
                        await Provider.of<KidImageProvider>(context,
                                listen: false)
                            .getKidImagesToCheck(widget.kid!.id!);
                      }
                      setState(() {
                        refreshData();
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(datesScreenCtx).showSnackBar(
                        SnackBar(
                          backgroundColor: success
                              ? Colors.green.shade400
                              : Colors.red.shade300,
                          content: Text(
                            success
                                ? AppLocalizations.of(context)!.imageSentSuc
                                : AppLocalizations.of(context)!
                                    .errorInSendingImage,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.green,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: isArabic ? 0 : null,
                left: isArabic ? null : 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red.withOpacity(0.3),
                  maxRadius: 20.sp,
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool success = await Provider.of<KidImageProvider>(
                              context,
                              listen: false)
                          .deleteImageCopy(photos[i].id!);
                      await refreshData();
                      if (success) {
                        await Provider.of<KidImageProvider>(context,
                                listen: false)
                            .getKidImagesToCheck(widget.kid!.id!);
                      }
                      setState(() {
                        refreshData();
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(datesScreenCtx).showSnackBar(
                        SnackBar(
                          backgroundColor: success
                              ? Colors.green.shade400
                              : Colors.red.shade300,
                          content: Text(
                            success
                                ? AppLocalizations.of(context)!.imageDeletedSuc
                                : AppLocalizations.of(context)!
                                    .errorInDeletingImage,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
