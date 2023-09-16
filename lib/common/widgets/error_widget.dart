import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toddily_preschool/common/widgets/yellow_wifi_animation.dart';

class CustomErrorWidget extends StatelessWidget {
  double? height;
  CustomErrorWidget({this.height = 150});

  @override
  Widget build(BuildContext context) {
    bool isArabic =
        Provider.of<LanguageProvider>(context, listen: false).isArabic();
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height!.h,
            ),
            YellowWifiAnimation(),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.error,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: isArabic ? 30.sp : 24.sp,
                    fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              AppLocalizations.of(context)!.checkInternet,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: isArabic ? 22.sp : 20.sp,
                  fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                  color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
