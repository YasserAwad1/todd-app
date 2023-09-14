// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:toddily_preschool/models/kids/kid_model.dart';
// import 'package:toddily_preschool/social_media_expert/providers/camera_provider.dart';
// import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
// import 'package:toddily_preschool/main/kids/widgets/dates_screen_button.dart';

// class TakenImagesScreen extends StatefulWidget {
//   static const routeName = '/taken-images-screen';
//   KidModel? kid;
//   TakenImagesScreen({this.kid});

//   @override
//   State<TakenImagesScreen> createState() => _TakenImagesScreenState();
// }

// class _TakenImagesScreenState extends State<TakenImagesScreen> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     List<XFile> images = Provider.of<CameraProvider>(context).getTakenImages();
//     return Scaffold(
//       extendBody: true,
//       appBar: CustomAppBar(
//         scaffoldKey: null,
//         title: widget.kid!.name,
//         titleContainerWidth: 200.w,
//         withBackButton: true,
//       ),
//       bottomNavigationBar: isLoading
//           ? Center(
//               child: Platform.isIOS
//                   ? const CupertinoActivityIndicator()
//                   : CircularProgressIndicator(
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//             )
//           : Padding(
//               padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
//               child: TextButton.icon(
//                 style: TextButton.styleFrom(
//                   backgroundColor:
//                       Theme.of(context).colorScheme.secondary.withOpacity(0.9),
//                 ),
//                 onPressed: () async {
//                   setState(() {
//                     isLoading = true;
//                   });
//                   await Provider.of<CameraProvider>(context, listen: false)
//                       .sendKidImages(widget.kid!.id!);
//                   setState(() {
//                     isLoading = false;
//                   });
//                 },
//                 icon: Icon(
//                   Icons.send,
//                   color: Colors.white,
//                   size: 27.sp,
//                 ),
//                 label: Text(
//                   'Send Images',
//                   style: TextStyle(color: Colors.white, fontSize: 18.sp),
//                 ),
//               ),
//             ),
//       body: images.isNotEmpty
//           ? Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: images.length,
//                       itemBuilder: (context, i) {
//                         return Container(
//                             margin: EdgeInsets.all(10.sp),
//                             height: 270.h,
//                             width: 130.w,
//                             child: Center(
//                               child: Stack(
//                                 children: [
//                                   Image.file(
//                                     File(images[i].path),
//                                   ),
//                                   Positioned(
//                                     top: 0,
//                                     right: 0,
//                                     child: Container(
//                                       width: 45.w,
//                                       height: 45.h,
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .primary
//                                             .withOpacity(0.7),
//                                         borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(
//                                             15.sp,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               images.removeAt(i);
//                                               print('**********************');
//                                               print(images.length);
//                                               print('**********************');
//                                             });
//                                           },
//                                           icon: Icon(
//                                             Icons.delete_outline,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ));
//                       }),
//                 )
//               ],
//             )
//           : Center(
//               child: Text('no images'),
//             ),
//     );
//   }
// }
