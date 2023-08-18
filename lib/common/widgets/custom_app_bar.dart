import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String title;
  final double titleContainerWidth;
  final bool withBackButton;
  bool? withNotification = true;

  CustomAppBar({
    required this.scaffoldKey,
    required this.title,
    required this.titleContainerWidth,
    required this.withBackButton,
    this.withNotification,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        if (Provider.of<EventProvider>(context).getRole == 0)
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
              size: 25.sp,
            ),
          )
      ],
      leading: !withBackButton
          ? Padding(
              padding: EdgeInsets.only(top: 7.h, left: 10.w),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  onPressed: () {
                    scaffoldKey?.currentState!.openDrawer();
                  },
                  icon: Icon(
                    Icons.clear_all_rounded,
                    color: Colors.white,
                    size: 26.sp,
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 7.h, left: 6.w),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.sp,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
      elevation: 0,
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.only(top: 7.h),
        height: 40.h,
        width: titleContainerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 13.h,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "LuckiestGuy",
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
