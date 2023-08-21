import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/common/social_media_expert/providers/camera_provider.dart';

class CustomCamera extends StatefulWidget {
  const CustomCamera({super.key});

  @override
  State<CustomCamera> createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  double buttonSize = 28.sp;

  void _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.medium,
    );

    await _cameraController!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile capturedImage = await _cameraController!.takePicture();
      setState(
        () {
          Provider.of<CameraProvider>(context, listen: false)
              .addImages(capturedImage);

          buttonSize = 20.sp;
          // Simulate a delay to see the animation
          Future.delayed(
            const Duration(milliseconds: 300),
            () {
              setState(
                () {
                  // Reset the properties of the button after the animation
                  buttonSize = 28.sp;
                },
              );
            },
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _pickPhoto() async {
  //   try {
  //     final XFile? pickedImage =
  //         await _imagePicker.pickImage(source: ImageSource.gallery);
  //     if (pickedImage != null) {
  //       setState(() {
  //         _capturedImages.add(pickedImage);
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 510.h,
          child: CameraPreview(_cameraController!),
        ),
        Positioned(
          bottom: 15.h,
          left: 150.w,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            radius: 30.sp,
            child: IconButton(
              alignment: Alignment.center,
              splashColor: Colors.red,
              onPressed: _takePhoto,
              icon: Icon(
                Icons.camera,
                color: Colors.white,
                size: buttonSize.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
