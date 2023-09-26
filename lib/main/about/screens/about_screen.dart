import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/drawer/app_drawer.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/common/widgets/app_place_holder.dart';
import 'package:toddily_preschool/common/widgets/error_widget.dart';
import 'package:toddily_preschool/common/widgets/no_information_widget.dart';
import 'package:toddily_preschool/common/widgets/ripple.dart';
import 'package:toddily_preschool/main/about/providers/about_provider.dart';
import 'package:toddily_preschool/main/about/widgets/about_top_bar.dart';
import 'package:toddily_preschool/main/about/widgets/about_widget.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toddily_preschool/main/about/widgets/details_list.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about-screen';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool startAnimation = false;
  var _photosFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _photosFuture =
        Provider.of<AboutProvider>(context, listen: false).getPhotos();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(
        _phoneUri,
      )) {
        await launchUrl(
          _phoneUri,
        );
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    await precacheImage(
        const AssetImage(
          "assets/images/toddilyOuterLogo.jpg",
        ),
        context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();
    print(Provider.of<UserProvider>(context, listen: false).getUserRoleId());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            launchPhoneDialer('+963987056446');
          },
          child: const Icon(
            Icons.call,
          ),
        ),
        drawerEdgeDragWidth: 100.w,
        // extendBody: true,
        drawerEnableOpenDragGesture: true,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder:
              ((BuildContext context, bool innerBoxIsScrolled) {
            print(innerBoxIsScrolled);
            return <Widget>[
              AboutTopBar(
                scaffoldKey: _scaffoldKey,
                isArabic: isArabic,
              ),
            ];
          }),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  AboutWidget(
                    startAnimation: startAnimation,
                    index: 1,
                    isArabic: isArabic,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const DetailsList(),
                  SizedBox(
                    height: 10.h,
                  ),
                  FutureBuilder(
                      future: _photosFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return RippleWidget();
                        }
                        if (Provider.of<AboutProvider>(context, listen: false)
                            .hasError) {
                          return CustomErrorWidget();
                        }
                        List<PhotoModel> photos =
                            Provider.of<AboutProvider>(context, listen: false)
                                .aboutImages;
                        if (photos.isEmpty) {
                          return NoInformationWidget(
                            height: 1,
                          );
                        }
                        return CarouselSlider.builder(
                          itemBuilder: ((context, index, realIndex) =>
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 25.w),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(
                                    20.sp,
                                  ),
                                ),
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  child: Image.network(
                                    '${Endpoints.baseUrl}${photos[index].image_url}',
                                    fit: BoxFit.contain,
                                    frameBuilder:
                                        (_, image, loadingBuilder, __) {
                                      if (loadingBuilder == null) {
                                        return AppPlaceholder(
                                            child: Container(
                                          color: Colors.black,
                                          height: 200.h,
                                        ));
                                      }
                                      return image;
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) => Image(
                                      image:
                                          AssetImage('images/image_error.jpg'),
                                      height: 160.h,
                                    ),
                                  ),
                                ),
                              )),
                          itemCount: photos.length,
                          options: CarouselOptions(
                            pauseAutoPlayOnTouch: true,
                            autoPlay: true,
                            viewportFraction: 1.sp,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false,
                            aspectRatio: 16 / 9,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
