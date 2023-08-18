import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/widgets/app_drawer.dart';
import 'package:toddily_preschool/main/about/widgets/about_top_bar.dart';
import 'package:toddily_preschool/main/about/widgets/about_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toddily_preschool/main/about/widgets/details_list.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about-screen';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> images = [
    'assets/images/todd.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/water.jpg',
    'assets/images/todd.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/water.jpg',
  ];

  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(
        _phoneUri,
      ))
        await launchUrl(
          _phoneUri,
        );
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
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            launchPhoneDialer('+963987056446');
          },
          child: Icon(
            Icons.call,
          ),
        ),
        drawerEdgeDragWidth: 100.w,
        // extendBody: true,
        drawerEnableOpenDragGesture: true,
        drawer: AppDrawer(),
        key: _scaffoldKey,
        body: NestedScrollView(
          headerSliverBuilder:
              ((BuildContext context, bool innerBoxIsScrolled) {
            print(innerBoxIsScrolled);
            return <Widget>[
              AboutTopBar(
                scaffoldKey: _scaffoldKey,
              ),
            ];
          }),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: 40.h,
                  //   width: 205.w,
                  //   padding: EdgeInsets.all(5.sp),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).colorScheme.secondary,
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         color: Colors.grey,
                  //         spreadRadius: 0.9,
                  //         blurRadius: 10,
                  //         offset: Offset(6, 7),
                  //       ),
                  //     ],
                  //     borderRadius: BorderRadius.only(
                  //         // topRight: isArabic ? Radius.zero : Radius.circular(10.sp.sp),
                  //         // bottomRight: isArabic ? Radius.zero : Radius.circular(10.sp.sp),
                  //         // topLeft: isArabic ? Radius.circular(10.sp.sp) : Radius.zero,
                  //         // bottomLeft: isArabic ? Radius.circular(10.sp.sp) : Radius.zero,
                  //         bottomRight: Radius.circular(10.sp),
                  //         topRight: Radius.circular(10.sp)),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       'About Toddily Preschool',
                  // style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 17.sp,
                  //     color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const AboutWidget(),
                  SizedBox(
                    height: 10.h,
                  ),
                  const DetailsList(),
                  SizedBox(
                    height: 10.h,
                  ),
                  CarouselSlider.builder(
                    itemBuilder: ((context, index, realIndex) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(
                          20.sp,
                        ),
                      ),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
                    itemCount: images.length,
                    options: CarouselOptions(
                      pauseAutoPlayOnTouch: true,
                      autoPlay: true,
                      viewportFraction: 1.sp,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
