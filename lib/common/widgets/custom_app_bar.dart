import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/common/navigators/my_navigator.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/events/providers/event_provider.dart';
import 'package:toddily_preschool/main/notifications/screens/notifications_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String title;
  final double titleContainerWidth;
  final bool withBackButton;
  final bool stayEnglish;
  final bool withNotification;

  CustomAppBar({
    required this.scaffoldKey,
    required this.title,
    required this.titleContainerWidth,
    required this.withBackButton,
    this.withNotification = true,
    this.stayEnglish = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();
    return AppBar(
      actions: [
        if (Provider.of<UserProvider>(context).getUserRoleId() == 5 &&
            withNotification)
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MyNavigator(
                  screen: const NotificationsScreen(),
                  curves: Curves.ease,
                ),
              );
            },
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
              size: 25.sp,
            ),
          )
      ],
      leading: !withBackButton
          ? Padding(
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
              padding: EdgeInsets.only(
                top: 7.h,
                left: isArabic ? 0 : 6.w,
                right: isArabic ? 6.w : 0,
              ),
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
                  //TODO
                  // IF COMING FROM NOTIFICATION, MAKE IT PUSH NAMED KIDS SCREEN
                  Navigator.of(context).pop();
                },
                child: Icon(
                  isArabic
                      ? Icons.arrow_back_ios_rounded
                      : Icons.arrow_back_ios_new,
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
                height: isArabic && stayEnglish ? 5.h : 13.h,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily:
                        isArabic && stayEnglish ? "Lalezar" : "LuckiestGuy",
                    fontSize: isArabic && stayEnglish ? 22 : 20),
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
