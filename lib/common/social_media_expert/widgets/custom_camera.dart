import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _capturedImages = [];

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
      setState(() {
        Provider.of<CameraProvider>(context, listen: false)
            .addImages(capturedImage);
      });
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
          child: InkWell(
            onTap: _takePhoto,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 28.0,
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
