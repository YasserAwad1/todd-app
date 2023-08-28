import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:toddily_preschool/auth/widgets/custom_textformfeild.dart';
import 'package:toddily_preschool/auth/widgets/guest_login_button.dart';
import 'package:toddily_preschool/auth/widgets/login_button.dart';
import 'package:toddily_preschool/auth/widgets/or_widget.dart';
import 'package:toddily_preschool/auth/widgets/sigin_top_bar.dart';
import 'package:toddily_preschool/common/providers/language_provider.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Provider.of<LanguageProvider>(context).isArabic();

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            SigninTopBar(
              isArabic: isArabic,
            ),
            Stack(
              fit: StackFit.passthrough,
              children: [
                Positioned(
                  left: isArabic ? null : 20.w,
                  right: isArabic ? 20.w : null,
                  top: 0,
                  child: SizedBox(
                    height: 100.h,
                    width: 120.w,
                    child: Image.asset(
                      'assets/images/characters/honey.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: isArabic ? null : -14.w,
                  left: isArabic ? 1.w : null,
                  top: 32.h,
                  child: SizedBox(
                    height: 100.h,
                    width: 120.w,
                    child: Image.asset(
                      'assets/images/characters/world.png',
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: -5.w,
                  bottom: 140.h,
                  child: SizedBox(
                    height: 100.h,
                    width: 120.w,
                    child: Image.asset(
                      'assets/images/characters/pen.png',
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 50.w,
                  bottom: isArabic ? 185.h : 180.h,
                  child: SizedBox(
                    height: 100.h,
                    width: 120.w,
                    child: Image.asset(
                      'assets/images/birds.png',
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: isArabic ? null : 30.w,
                  left: isArabic ? 50.w : null,
                  top: 30.h,
                  child: SizedBox(
                    height: 150.h,
                    width: 150.w,
                    child: Text(
                      AppLocalizations.of(context)!.loginToYourAccount,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: isArabic ? 27.sp : 30.sp,
                        fontFamily: isArabic ? "Lalezar" : "LuckiestGuy",
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110.h,
                        ),
                        CustomTextFormFeild(
                            labelText: AppLocalizations.of(context)!.userName),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFeild(
                            labelText: AppLocalizations.of(context)!.password),
                        SizedBox(
                          height: 20.h,
                        ),
                        LoginButton(
                          isArabic: isArabic,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const OrWidget(),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 100.h,
                              width: 120.w,
                              child: Image.asset(
                                'assets/images/characters/book.png',
                                // fit: BoxFit.fill,
                              ),
                            ),
                            GuestLoginButton(
                              isArabic: isArabic,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
