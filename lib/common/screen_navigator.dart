// import 'package:flutter/material.dart';

// class ScreenNavigator {
//   BuildContext context;
//   Widget screen;

//   ScreenNavigator({
//     required this.context,
//     required this.screen,
//   });

//   static Future push(context, screen, {bool animated = true}) {
//     if (animated) {
//       return Navigator.push(
//         context,
//         PageRouteBuilder(
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation,
//               child: child,
//             );
//           },
//           pageBuilder: (context, animation, secondaryAnimation) => screen,
//         ),
//       );
//     } else {
//       return Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => screen),
//       );
//     }
//   }

//   static void pop(BuildContext context, {bool animated = true}) {
//     if (animated) {
//       Navigator.pop(context);
//     } else {
//       Navigator.pop(context);
//     }
//   }
// }
