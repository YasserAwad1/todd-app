import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GuestLoginButton extends StatelessWidget {
  bool isArabic;
  GuestLoginButton({
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
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
