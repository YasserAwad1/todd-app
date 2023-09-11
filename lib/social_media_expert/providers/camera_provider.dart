import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/social_media_expert/service/kid_images_service.dart';

class CameraProvider with ChangeNotifier {
  KidImagesService service = KidImagesService();
  KidImageModel? kidImage;
  List<XFile> capturedImages = [];

  void addImages(XFile image) {
    capturedImages.add(image);
    notifyListeners();
  }

  List<XFile> getTakenImages() {
    return capturedImages;
  }

  sendKidImages(
    int childId,
  ) async {
    try {
      bool success =
          await service.sendKidImage(childId, File(capturedImages[0].path));
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
