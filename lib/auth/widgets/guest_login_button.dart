import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestLoginButton extends StatelessWidget {
  const GuestLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Login As A Guest',
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: "LuckiestGuy",
            fontSize: 20.sp),
      ),
    );
  }
}
