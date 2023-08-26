import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddily_preschool/auth/widgets/custom_textformfeild.dart';
import 'package:toddily_preschool/common/my_navigator.dart';
import 'package:toddily_preschool/main/kids/screens/kids_screen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15.sp),
                    width: 200.w,
                    height: 130.h,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(50)),
                        color: Theme.of(context).colorScheme.secondary),
                    child: Image.asset('assets/images/ToddilyLogo.png'),
                  ),
                ],
              ),
              SizedBox(
                width: 20.w,
              ),
              SizedBox(
                height: 130.h,
                width: 100.w,
                child: Image.asset(
                  'assets/images/characters/astro3.png',
                ),
              )
            ],
          ),
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
                  right: 20.w,
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
                  physics: NeverScrollableScrollPhysics(),
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
                        Container(
                          padding: EdgeInsets.all(10.sp),
                          width: 200.w,
                          height: 70.h,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        KidsScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              // icon: Icon(
                              //   Icons.login,
                              //   color: Colors.white,
                              //   size: 30.sp,
                              // ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "LuckiestGuy",
                                    fontSize: 30.sp),
                              )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary),
                              height: 1.5.h,
                              width: 130.w,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'OR',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary),
                              height: 1.5.h,
                              width: 130.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Login As A Guest',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontFamily: "LuckiestGuy",
                                  fontSize: 20.sp),
                            ))

                        // TextFormField(
                        //   style: TextStyle(fontSize: 16),
                        //   cursorColor: Colors.white,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     hintText: "UserName",
                        //     hintStyle: TextStyle(color: Colors.white),
                        //     alignLabelWithHint: false,
                        //     fillColor: Colors.blue,
                        //     filled: true,
                        //   ),
                        //   textInputAction: TextInputAction.done,
                        // ),
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
