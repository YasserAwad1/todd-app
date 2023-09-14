import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/social_media_expert/service/kid_images_service.dart';

class KidImageProvider with ChangeNotifier {
  KidImagesService service = KidImagesService();
  List<String?> chosenImages = [];

  sendKidImages(
    int childId,
  ) async {
    try {
      List<File?> imagesToSend = [];
      // print(chosenImages[0]);
      if (chosenImages.isNotEmpty) {
        for (int i = 0; i < chosenImages.length; i++) {
          imagesToSend.add(File(chosenImages[i]!));
        }
      }
      bool success = await service.sendKidImage(childId, imagesToSend);
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
