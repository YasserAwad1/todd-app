import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:toddily_preschool/auth/widgets/custom_textformfeild.dart';
import 'package:toddily_preschool/auth/widgets/guest_login_button.dart';
import 'package:toddily_preschool/auth/widgets/login_button.dart';
import 'package:toddily_preschool/auth/widgets/or_widget.dart';
import 'package:toddily_preschool/auth/widgets/sigin_top_bar.dart';


class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const SigninTopBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  left: 20.w,
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
                  right: -14.w,
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
                  left: -5.w,
                  bottom: 179.h,
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
                  right: -5.w,
                  bottom: 75.h,
                  child: SizedBox(
                    height: 100.h,
                    width: 120.w,
                    child: Image.asset(
                      'assets/images/characters/book.png',
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
                // Positioned(
                //   left: 40.w,
                //   bottom: 25.h,
                //   child: SizedBox(
                //     height: 100.h,
                //     width: 120.w,
                //     child: Image.asset(
                //       'assets/images/characters/astro1.png',
                //       // fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                Positioned(
                  right: 30.w,
                  top: 30.h,
                  child: SizedBox(
                    height: 150.h,
                    width: 150.w,
                    child: Text(
                      'Login To Your Account',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                        fontFamily: "LuckiestGuy",
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
                        CustomTextFormFeild(labelText: 'Username'),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormFeild(labelText: 'Password'),
                        SizedBox(
                          height: 20.h,
                        ),
                        LoginButton(),
                        SizedBox(
                          height: 10.h,
                        ),
                        OrWidget(),
                        SizedBox(
                          height: 15.h,
                        ),
                        GuestLoginButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
