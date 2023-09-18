import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/providers/auth_provider.dart';
import 'package:toddily_preschool/common/user/provider/user_provider.dart';
import 'package:toddily_preschool/main/classes/screens/classes_screen.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatefulWidget {
  bool isArabic;
  bool isLoading;
  BuildContext ctx;
  String userName;
  String password;
  // VoidCallback onPressedFunction;

  LoginButton({
    required this.isArabic,
    // required this.onPressedFunction,
    required this.isLoading,
    required this.ctx,
    required this.userName,
    required this.password,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  var userProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    bool? success;
    return Container(
      padding: EdgeInsets.all(10.sp),
      width: 200.w,
      height: 70.h,
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
          : TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () async {
                setState(() {
                  widget.isLoading = true;
                });
                success =
                    await Provider.of<AuthProvider>(widget.ctx, listen: false)
                        .login(
                  widget.userName,
                  widget.password,
                );
                if (success!) {
                  await userProvider.getCurrentUser();
                  setState(() {
                    widget.isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (ctx, animation, secondaryAnimation) {
                        if (userProvider.classesTile()) {
                          return ClassesScreen();
                        } else {
                          return KidsScreen();
                        }
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
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(widget.ctx).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        widget.userName.isEmpty || widget.password.isEmpty
                            ? AppLocalizations.of(context)!.allFeildsAreReq
                            : AppLocalizations.of(context)!.invalidCredentials,
                      ),
                    ),
                  );
                  setState(() {
                    widget.isLoading = false;
                  });
                }
              },
              child: Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: widget.isArabic ? "Lalezar" : "LuckiestGuy",
                    fontSize: widget.isArabic ? 27.sp : 30.sp),
              ),
            ),
    );
  }
}
