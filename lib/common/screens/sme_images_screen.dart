// import 'dart:io';

// import 'package:flutter/material.dart';

// class smeImagesScreen extends StatelessWidget {
//   static const routeName = '/sme-images-screen';
//   List<File>? images;
//   smeImagesScreen({this.images});

//   @override
//   Widget build(BuildContext context) {
//     print(images!.length);
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             child: Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: images!.length,
//                 itemBuilder: (context, i) => Image.file(
//                   images![i],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
