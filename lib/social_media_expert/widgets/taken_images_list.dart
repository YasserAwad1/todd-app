// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// import '../providers/camera_provider.dart';

// class TakenImagesList extends StatefulWidget {
//   const TakenImagesList({super.key});

//   @override
//   State<TakenImagesList> createState() => _TakenImagesListState();
// }

// class _TakenImagesListState extends State<TakenImagesList> {
//   List<XFile> _capturedImages = [];

//   @override
//   Widget build(BuildContext context) {
//   _capturedImages = Provider.of<CameraProvider>(context).getTakenImages();
  
//     return Container(
//       height: 100.h,
//       child: ListView.builder(
//         padding: EdgeInsets.all(5.sp),
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: _capturedImages.length,
//         itemBuilder: (context, i) => Container(
//           margin: EdgeInsets.symmetric(horizontal: 5.w),
//           child: Stack(
//             children: [
//               Image.file(
//                 File(_capturedImages[i].path),
//               ),
//               Positioned(
//                 top: -7.w,
//                 right: 8.w,
//                 child: Container(
//                   height: 20.h,
//                   width: 20.w,
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _capturedImages.removeAt(i);
//                       });
//                     },
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
