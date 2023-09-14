import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/social_media_expert/service/kid_images_service.dart';

class KidImageProvider with ChangeNotifier {
  KidImagesService service = KidImagesService();
  List<XFile> capturedImages = [];

  sendKidImages(
    int childId,
  ) async {
    try {
      List<File?> imagesToSend = [];
      for (int i = 0; i < capturedImages.length; i++) {
        imagesToSend.add(File(capturedImages[i].path));
      }
      bool success = await service.sendKidImage(childId, imagesToSend);
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
