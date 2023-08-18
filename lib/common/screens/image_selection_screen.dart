import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multiple_image_camera/camera_file.dart';
import 'package:multiple_image_camera/multiple_image_camera.dart';
import 'package:toddily_preschool/common/screens/sme_images_screen.dart';
import 'package:toddily_preschool/common/widgets/custom_app_bar.dart';
import 'package:multi_image_capture/multi_image_capture.dart';

class ImageSelectionScreen extends StatefulWidget {
  static const routeName = '/image-selection-screen';
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController listViewController = ScrollController();
  // List<MediaModel> images = [];
  List<File> images = [];
  List<File> preCapImages = [];

  double _scrollOffset = 0.0;

  double _getMaxScrollOffset() {
    // Calculate the maximum scroll offset based on the item count and width
    final itemCount = 10; // Replace with your actual item count
    final itemWidth = 50; // Set the desired width
    final containerWidth = MediaQuery.of(context).size.width;
    final maxScrollExtent = itemCount * itemWidth - containerWidth;
    return maxScrollExtent > 0 ? maxScrollExtent : 0;
  }

  @override
  void dispose() {
    listViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listViewController.addListener(() {
      setState(() {
        _scrollOffset = listViewController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        // appBar: CustomAppBar(
        //   scaffoldKey: _scaffoldKey,
        //   title: 'Image Capture',
        //   titleContainerWidth: 160.w,
        //   withBackButton: true,
        // ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.camera),
        //   onPressed: () async {
        //     MultipleImageCamera.capture(context: context).then((value) {
        //       setState(() {
        //         images = value;
        //       });
        //     });
        //   },
        // ),
        // bottomNavigationBar: BottomAppBar(
        //     color: Colors.transparent,
        //     elevation: 0,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         TextButton.icon(
        //           style: TextButton.styleFrom(
        //             backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        //           ),
        //           onPressed: () async {
        //             // await MultipleImageCamera.capture(context: context);
        //             // await MultipleImageCamera.capture(context: context).then((value) {
        //             //   setState(() {
        //             //     images = value;
        //             //   });
        //             // });
        //           },
        //           icon: Icon(Icons.camera, color: Colors.white),
        //           label: Text(
        //             'Take Photos',
        //             style: TextStyle(color: Colors.white, fontSize: 18.sp),
        //           ),
        //         ),
        //         TextButton.icon(
        //           style: TextButton.styleFrom(
        //             backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        //           ),
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.send,
        //             color: Colors.white,
        //           ),
        //           label: Text(
        //             'Send Photos',
        //             style: TextStyle(color: Colors.white, fontSize: 18.sp),
        //           ),
        //         ),
        //       ],
        //     )),
        body: Stack(
      children: [
        MultiImageCapture(
          // Toolbar title for the camera screen
          title: "Camera Capture",

          // Maximum number of images that can be captured at once
          maxImages: 5,

          // Previously captured images can be passed to resume from that point
          preCapturedImages: preCapImages,

          // Custom Theme Colors (By Default app theme colors will be taken)
          themePrimaryColor: Theme.of(context).colorScheme.secondary,
          themeSecondaryColor: Colors.white,

          // Icons for the buttons on the camera screen
          switchCameraButtonIcon: Icons.flip_camera_android,
          captureButtonIcon: Icons.camera,
          doneButtonIcon: Icons.done,

          // Design elements for the image delete button
          removeImageButtonIcon: Icons.remove,
          removeImageButtonSize: 21,
          removeImageButtonColor: Colors.amber,

          // Error message when maximum number of image capture is reached
          imageLimitErrorMessage:
              "You cannot capture more than 5 images at a time",

          //MANDATORY FIELDS

          onRemoveImage: (File image) async {
            print('onremove');
            /*
            * Can Show confirmation dialog here before returning to remove image
            * Return true; will remove image from list
            * Return false; will keep the image unchanged
          */

            return false;
          },
          onAddImage: (image) async {
            print('oneaddimages');
            setState(() {
              images.add(image);
              print(images.length);
            });
          },

          onComplete: (List<File> finalImages) {
            print(preCapImages.length);
            print(finalImages.length);
            print('oncomplete');
            // setState(() {
            //   images.addAll(finalImages);
            //   images = finalImages;
            //   // finalImages = images;
            // });
            print('setstate');
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => smeImagesScreen(
                    images: finalImages,
                  ),
                ));
            return images;
          },
        ),
        Positioned(
          bottom: 70.h,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _scrollOffset -= details.delta.dx;
                listViewController.jumpTo(_scrollOffset);
              });
            },
            // onHorizontalDragUpdate: (details) {
            //   setState(() {
            //     _scrollOffset -= details.delta.dx;
            //     // Limit the scroll range
            //     _scrollOffset = _scrollOffset.clamp(0, _getMaxScrollOffset());
            //     listViewController.jumpTo(_scrollOffset);
            //   });
            // },
            // onHorizontalDragUpdate: (details) {
            //   setState(() {
            //     _scrollOffset -= details.delta.dx;
            //     // Limit the scroll range
            //     _scrollOffset = _scrollOffset.clamp(0, _getMaxScrollOffset());
            //     if (_scrollOffset > _getMaxScrollOffset()) {
            //       _scrollOffset = _getMaxScrollOffset();
            //     }
            //     listViewController.jumpTo(_scrollOffset);
            //   });
            // },

            // onPanUpdate: (details) {
            //   // Swiping in right direction.
            //   if (details.delta.dx > 0) {

            //   }

            //   // Swiping in left direction.
            //   if (details.delta.dx < 0) {
            //     print('left');
            //     // listViewController.
            //   }
            // },
            child: Container(
              height: 90.h,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  controller: listViewController,
                  physics: PageScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.all(10),
                    width: 50.w,
                    height: 70.h,
                    color: Colors.red,
                    child: Image.file(
                      images[i],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    )

        //         Container(
        //   height: 150.h,
        //   child: GridView.builder(
        //       itemCount: 3,
        //       shrinkWrap: true,
        //       scrollDirection: Axis.horizontal,
        //       gridDelegate:
        //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        //       itemBuilder: (context, i) => Container(
        //             height: 100.h,
        //             width: 100.w,
        //             color: Colors.red,
        //           )),
        // )

        // Column(
        //   children: [
        //     // Expanded(
        //     //   child: ListView.builder(
        //     //       shrinkWrap: true,
        //     //       itemCount: images.length,
        //     //       itemBuilder: (context, index) {
        //     //         return Container(
        //     //             child: Stack(
        //     //           children: [
        //     //             Image.file(
        //     //               File(images[index].file.path),
        //     //             ),
        //     //             Positioned(
        //     //               top: 0,
        //     //               right: 0,
        //     //               child: Container(
        //     //                 width: 50.w,
        //     //                 height: 50.h,
        //     //                 decoration: BoxDecoration(
        //     //                   color: Theme.of(context)
        //     //                       .colorScheme
        //     //                       .primary
        //     //                       .withOpacity(0.7),
        //     //                   borderRadius: BorderRadius.only(
        //     //                     bottomLeft: Radius.circular(
        //     //                       15.sp,
        //     //                     ),
        //     //                   ),
        //     //                 ),
        //     //                 child: IconButton(
        //     //                   onPressed: () {
        //     //                     setState(() {
        //     //                       images.removeAt(index);
        //     //                       print('**********************');
        //     //                       print(images.length);
        //     //                       print('**********************');
        //     //                     });
        //     //                   },
        //     //                   icon: Icon(
        //     //                     Icons.delete_outline,
        //     //                     color: Colors.red,
        //     //                   ),
        //     //                 ),
        //     //               ),
        //     //             ),
        //     //           ],
        //     //         ));
        //     //       }),
        //     // )
        //   ],
        // ),
        );
  }
}
