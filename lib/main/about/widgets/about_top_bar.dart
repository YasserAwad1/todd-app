import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/common/widgets/app_place_holder.dart';

class AboutTopBar extends StatelessWidget {
  var scaffoldKey;
  bool isArabic;
  AboutTopBar({required this.scaffoldKey, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: 250,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/toddilyOuterLogo.jpg',
          fit: BoxFit.fill,
          frameBuilder: (_, image, loadingBuilder, __) {
            if (loadingBuilder == null) {
              return AppPlaceholder(
                  child: Container(
                color: Colors.black,
                height: 200.h,
              ));
            }
            return image;
          },
          errorBuilder: (context, error, stackTrace) => Image(
            image: AssetImage('images/image_error.jpg'),
            height: 160.h,
          ),
        ),
        collapseMode: CollapseMode.parallax,
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
