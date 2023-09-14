// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:toddily_preschool/common/my_navigator.dart';
// import 'package:toddily_preschool/models/kids/kid_model.dart';
// import 'package:toddily_preschool/social_media_expert/providers/camera_provider.dart';
// import 'package:toddily_preschool/social_media_expert/screens/taken_images_screen.dart';
// import 'package:toddily_preschool/social_media_expert/widgets/custom_camera.dart';
// import 'package:toddily_preschool/social_media_expert/widgets/taken_images_list.dart';

// class CameraScreen extends StatefulWidget {
//   static const routeName = '/camera-screen';
//   KidModel? kid;
//   CameraScreen({this.kid});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   @override
//   Widget build(BuildContext context) {
//     List<XFile> images = Provider.of<CameraProvider>(context).getTakenImages();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         title: Text(widget.kid!.name),
//         actions: [
//           IconButton(
//             onPressed: () {
//               images.isEmpty
//                   ? showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Are You Sure You Want To Exit ?'),
//                           content: Text(
//                             'You haven\'t taken any photo of ${widget.kid!.name}, \nNo photos will be sent.',
//                             style: TextStyle(
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           actions: [
//                             TextButton(
//                               child: Text(
//                                 'yes',
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MyNavigator(
//                                     curves: Curves.ease,
//                                     screen: TakenImagesScreen(kid: widget.kid),
//                                   ),
//                                 );
//                               },
//                             ),
//                             TextButton(
//                               child: Text(
//                                 'No',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             )
//                           ],
//                         );
//                       })
//                   : Navigator.push(
//                       context,
//                       MyNavigator(
//                         curves: Curves.ease,
//                         screen: TakenImagesScreen(
//                           kid: widget.kid!,
//                         ),
//                       ),
//                     );
//             },
//             icon: const Icon(
//               Icons.check,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 CustomCamera(),
//                 TakenImagesList(),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
