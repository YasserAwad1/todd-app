import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/about/screens/about_screen.dart';

class GuestLoginButton extends StatelessWidget {
  bool isArabic;
  GuestLoginButton({
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Provider.of<UserProvider>(context, listen: false).assignGuest();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (ctx, animation, secondaryAnimation) {
              return AboutScreen();
            },
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
        AppLocalizations.of(context)!.loginAsAGuest,
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
            fontSize: 23.sp),
      ),
    );
  }
}
