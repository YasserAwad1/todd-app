import 'package:flutter/material.dart';

class MyNavigator extends PageRouteBuilder {
  final Widget screen;
  final Curve curves;

  MyNavigator({required this.screen, required this.curves})
      : super(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            // var curve = Curves.easeOutBack;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curves));

            // if (animation.status == AnimationStatus.reverse) {
            //   tween =
            //       Tween(begin: end, end: begin).chain(CurveTween(curve: curve));
            // }

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
