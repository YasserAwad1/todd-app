import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  bool isArabic;
  LoginButton({
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      width: 200.w,
      height: 70.h,
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    KidsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.login,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                fontSize: isArabic ? 27.sp : 30.sp),
          )),
    );
  }
}
