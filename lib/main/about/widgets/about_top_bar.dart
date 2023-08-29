import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutTopBar extends StatelessWidget {
  var scaffoldKey;
  bool isArabic;
  AboutTopBar({required this.scaffoldKey, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      // title: Container(
      //   padding: EdgeInsets.all(5.sp),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadiusDirectional.circular(15.sp),
      //     color: Theme.of(context).colorScheme.secondary.withOpacity(
      //           0.8,
      //         ),
      //   ),
      //   child: Text(
      //     'About Toddily Preschool',
      //   ),
      // ),
      expandedHeight: 250,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/toddilyOuterLogo.jpg',
          fit: BoxFit.fill,
        ),
        // centerTitle: true,
        collapseMode: CollapseMode.parallax,
        // titlePadding: EdgeInsets.all(8.sp),
        // title: Text(
        //   'About Toddily Preschool',
        //   style:
        //       TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        // ),
      ),
      backgroundColor: Colors.white,
      leading: Padding(
        padding: EdgeInsets.only(
          top: 7.h,
          left: isArabic ? 0 : 10.w,
          right: isArabic ? 10.w : 0,
        ),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: IconButton(
            highlightColor: Colors.transparent,
            splashColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.clear_all_rounded,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
        ),
      ),
    );
  }
}
