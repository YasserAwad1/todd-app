import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/main/splash_screen/splash_screen.dart';
import 'package:toddily_preschool/main/splash_screen/widgets/wifi_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      content: Container(
        width: double.infinity.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              // alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: 210.h,
                ),
                Positioned(top: 10.h, left: 35.w, child: WifiAnimation()),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppLocalizations.of(context)!.noInternetConnection,
              style: TextStyle(fontFamily: "LuckiestGuy", color: Colors.black),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SplashScreen.routeName);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    AppLocalizations.of(context)!.tryAgain,
                    style: const TextStyle(
                        fontFamily: "LuckiestGuy", color: Colors.white),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    exit(0);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    AppLocalizations.of(context)!.exit,
                    style: const TextStyle(
                        fontFamily: "LuckiestGuy", color: Colors.white),
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
