import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/common/drawer/logout_button.dart';

import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/common/drawer/LanguageButtons.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/photos/screens/photos_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Color yellow = Theme.of(context).colorScheme.secondary;
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();

    return Drawer(
      width: 270.w,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 135.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              color: yellow,
            ),
            child: Container(
                margin: EdgeInsets.all(17.sp),
                child: Image.asset(
                  'assets/images/ToddilyLogo.png',
                  fit: BoxFit.fill,
                )),
          ),
          //CLASSES TILE FOR DOCTOR AND SOCIAL MEDIA EXPERT
          if (Provider.of<UserProvider>(context).classesTile())
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.class_outlined,
                    color: yellow,
                    size: 26.sp,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.classes,
                        style: TextStyle(
                            fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                            fontSize: isArabic ? 18 : 14.sp),
                      ),
                    ],
                  ),
                  splashColor: yellow.withOpacity(0.9),
                  onTap: () async {
                    Navigator.pop(context);
                    await Future.delayed(
                        const Duration(milliseconds: 50)); // wait some time
                    Navigator.pushReplacementNamed(
                      context,
                      '/classes-screen',
                    );
                  },
                ),
                Divider(
                  color: yellow,
                  thickness: 0.3.h,
                ),
              ],
            ),
          //KIDS TILE
          if (Provider.of<UserProvider>(context).kidsTile())
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.child_care_rounded,
                    color: yellow,
                    size: 26.sp,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.kids,
                        style: TextStyle(
                            fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                            fontSize: isArabic ? 18 : 14.sp),
                      ),
                    ],
                  ),
                  splashColor: yellow.withOpacity(0.9),
                  onTap: () async {
                    Navigator.pop(context);
                    await Future.delayed(
                        const Duration(milliseconds: 50)); // wait some time
                    Navigator.pushReplacementNamed(
                      context,
                      '/kids-screen',
                    );
                  },
                ),
                Divider(
                  color: yellow,
                  thickness: 0.3.h,
                ),
              ],
            ),

          //LATEST PHOTOS TILE
          ListTile(
            leading: Icon(
              Icons.photo_library_outlined,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  AppLocalizations.of(context)!.latestPhotos,
                  style: TextStyle(
                      fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                      fontSize: isArabic ? 18 : 14.sp),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () async {
              // Navigator.pop(context);
              // await Future.delayed(
              //     const Duration(milliseconds: 50)); // wait some time
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhotosScreen(),
                ),
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //EVENTS TILE
          ListTile(
            leading: Icon(
              Icons.event,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  AppLocalizations.of(context)!.events,
                  style: TextStyle(
                      fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                      fontSize: isArabic ? 18 : 14.sp),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Navigator.pop(context);
              // await Future.delayed(
              //     const Duration(milliseconds: 50)); // wait some time
              Navigator.pushReplacementNamed(
                context,
                '/events-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //ABOUT TODDILY PRESCHOOL TILE
          ListTile(
            leading: Icon(
              Icons.warning_amber_sharp,
              color: yellow,
              size: 26.sp,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  AppLocalizations.of(context)!.aboutToddilyps,
                  style: TextStyle(
                      fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                      fontSize: isArabic ? 18 : 14.sp),
                ),
              ],
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Navigator.pop(context);
              // await Future.delayed(
              //     const Duration(milliseconds: 50)); // wait some time
              Navigator.pushReplacementNamed(
                context,
                '/about-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),

          //FREQUENTLY ASKED QUESTIONS TILE
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: yellow,
              size: 26.sp,
            ),
            title: Text(
              AppLocalizations.of(context)!.faqs,
              style: TextStyle(
                  fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                  fontSize: isArabic ? 18 : 14.sp),
            ),
            splashColor: yellow.withOpacity(0.9),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                '/FAQ-screen',
              );
            },
          ),
          Divider(
            color: yellow,
            thickness: 0.3.h,
          ),
          SizedBox(
            height: 10.h,
          ),

          //BUTTONS ROW
          LanguageButtons(
            isArabic: isArabic,
          ),
          
          //LOGOUT
          logoutButton(
            isArabic: isArabic,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
