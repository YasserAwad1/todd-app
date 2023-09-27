import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:toddily_preschool/main/splash_screen/splash_screen.dart';
import 'package:toddily_preschool/main/splash_screen/widgets/wifi_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInternetDialog extends StatelessWidget {
  int tryAgain;
  NoInternetDialog({
    required this.tryAgain,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      content: Container(
        width: double.infinity.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 220.h,
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  WifiAnimation(),
                ],
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              AppLocalizations.of(context)!.noInternetConnection,
              style: TextStyle(
                  fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                  color: Colors.black),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    if (tryAgain == 0) {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacementNamed(SplashScreen.routeName);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    AppLocalizations.of(context)!.tryAgain,
                    style: TextStyle(
                        fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                        color: Colors.white),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    exit(0);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    AppLocalizations.of(context)!.exit,
                    style: TextStyle(
                        fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(0.sp),
    );
  }
}
