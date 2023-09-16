import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_image_widget.dart';
import 'package:toddily_preschool/main/kids/widgets/kid_image_widget_to_check.dart';
import 'package:toddily_preschool/main/photos/widgets/image_widget.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:toddily_preschool/social_media_expert/providers/kid_image_provider.dart';

class KidPhotosScreen extends StatefulWidget {
  KidModel? kid;
  KidPhotosScreen({required this.kid});

  @override
  State<KidPhotosScreen> createState() => _KidPhotosScreenState();
}

class _KidPhotosScreenState extends State<KidPhotosScreen> {
  bool startAnimation = false;
  var _kidPhotosFuture;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kidPhotosFuture = Provider.of<KidImageProvider>(context, listen: false)
        .getKidImagesToCheck(widget.kid!.id!);
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
      body: Column(
        children: [
          isLoading
              ? RippleWidget()
              : FutureBuilder(
                  future: _kidPhotosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return RippleWidget();
                    }
                    if (Provider.of<KidImageProvider>(context, listen: false)
                        .hasError) {
                      return CustomErrorWidget();
                    }
                    Provider.of<KidImageProvider>(context, listen: false)
                        .getKidImagesToCheck(widget.kid!.id!);
                    List<KidImageModel> photos =
                        Provider.of<KidImageProvider>(context, listen: false)
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
                          ),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.sp),
                              child: GestureDetector(
                                onTap: () {},
                                child: AnimatedContainer(
                                  curve: Curves.easeOutSine,
                                  duration: Duration(
                                    milliseconds: 500 + (i * 100),
                                  ),
                                  transform: Matrix4.translationValues(
                                    startAnimation
                                        ? 0
                                        : MediaQuery.of(context).size.width,
                                    0,
                                    0,
                                  ),
                                  width: double.infinity,
                                  height: 150.h,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        child: Image.network(
                                          '${Endpoints.baseUrl}${photos[i].image}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: isArabic ? null : 0,
                                        left: isArabic ? 0 : null,
                                        child: IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            // bool success =
                                            await Provider.of<KidImageProvider>(
                                                    context,
                                                    listen: false)
                                                .checkImage(photos[i].id!);
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   SnackBar(
                                            //     backgroundColor: success
                                            //         ? Colors.green.shade400
                                            //         : Colors.red.shade300,
                                            //     content: Text(
                                            //       success
                                            //           ? 'Image checked successfully'
                                            //           : 'Error in checking image',
                                            //     ),
                                            //   ),
                                            // );
                                            // if (success) {
                                            // await Provider.of<KidImageProvider>(
                                            //         context,
                                            //         listen: false)
                                            //     .getKidImagesToCheck(
                                            //         widget.kid!.id!);
                                            // }
                                            setState(() {
                                              refreshData();
                                              isLoading = false;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: isArabic ? 0 : null,
                                        left: isArabic ? null : 0,
                                        child: IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            // bool success =
                                            await Provider.of<KidImageProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteImageCopy(photos[i].id!);
                                            await refreshData();
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(
                                            //   SnackBar(
                                            //     backgroundColor: success
                                            //         ? Colors.green.shade400
                                            //         : Colors.red.shade300,
                                            //     content: Text(
                                            //       success
                                            //           ? 'Image deleted successfully'
                                            //           : 'Error in deleting image',
                                            //     ),
                                            //   ),
                                            // );
                                            // if (success) {
                                            // await Provider.of<KidImageProvider>(
                                            //         context,
                                            //         listen: false)
                                            //     .getKidImagesToCheck(
                                            //         widget.kid!.id!);
                                            // }
                                            setState(() {
                                              isLoading = false;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons
                                                .remove_circle_outline_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
        ],
      ),
    ));
  }
}
