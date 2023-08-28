import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/main/photos/screens/image_list_screen.dart';

class ImageWidget extends StatelessWidget {
  List<String> images = [
    'assets/images/todd.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/water.jpg',
    'assets/images/todd.jpg',
    'assets/images/avatar2.jpg',
    'assets/images/water.jpg',
  ];

  final String? title;
  final bool? isPhotosScreen;
  bool startAnimation;
  int index;

  ImageWidget({
    required this.startAnimation,
    required this.index,
    this.title,
    this.isPhotosScreen,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();

    return Padding(
        padding: EdgeInsets.only(top: 8.sp),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageListScreen(
                    images: images,
                    sentIndex: 2,
                    title: title,
                  ),
                ));
          },
          child: AnimatedContainer(
            curve: Curves.easeOutSine,
            duration: Duration(
              milliseconds: 500 + (index * 100),
            ),
            transform: Matrix4.translationValues(
                startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
            width: double.infinity,
            height: 150.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: Image.asset(
                    'assets/images/todd.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: isArabic ? null : 0,
                  left: isArabic ? 0 : null,
                  child: Container(
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(isArabic ? 0 : 10.sp),
                        topRight: Radius.circular(isArabic ? 0 : 15.sp),
                        bottomRight: Radius.circular(isArabic ? 10.sp : 0),
                        topLeft: Radius.circular(isArabic ? 15.sp : 0),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.download,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 28.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
