import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

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
            Image.asset(
              'assets/images/characters/astro3.png',
              scale: 1.5,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              AppLocalizations.of(context)!.error,
              style: TextStyle(
                  fontSize: isArabic ? 30.sp : 25.sp,
                  fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                  color: Theme.of(context).colorScheme.secondary),
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