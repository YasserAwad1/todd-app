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
                    height: 210.h,
                    color: Theme.of(context).colorScheme.secondary),
                Positioned(top: 10.h, left: 35.w, child: WifiAnimation()),
              ],
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16, right: 16),
            //   child: Text("Something Went Wrong",
            //       style: TextStyle(
            //         fontSize: 14,
            //       )),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'No Internet Conntection',
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
                    Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                        fontFamily: "LuckiestGuy", color: Colors.white),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    exit(0);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Exit',
                    style: TextStyle(
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
