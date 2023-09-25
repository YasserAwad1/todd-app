import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/main/auth/screens/sign_in_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class logoutButton extends StatefulWidget {
  bool isArabic;
  bool isLoading;
  logoutButton({
    required this.isArabic,
    required this.isLoading,
  });

  @override
  State<logoutButton> createState() => _logoutButtonState();
}

class _logoutButtonState extends State<logoutButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: widget.isLoading
          ? Center(
              child: Platform.isAndroid
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : CupertinoActivityIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
            )
          : TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20.sp,
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  widget.isLoading = true;
                });
                final loggedOut =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logOut();
                if (loggedOut) {
                  setState(() {
                    widget.isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (ctx, animation, secondaryAnimation) =>
                          SignInScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                } else {
                  setState(() {
                    widget.isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        AppLocalizations.of(context)!.errorOccurred,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: widget.isArabic ? "Lalezar" : "LuckiestGuy",
                        fontSize: widget.isArabic ? 18.sp : 20.sp),
                  ),
                ],
              ),
            ),
    );
  }
}
