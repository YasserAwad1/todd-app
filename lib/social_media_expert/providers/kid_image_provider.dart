import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/social_media_expert/service/kid_images_service.dart';

class KidImageProvider with ChangeNotifier {
  KidImagesService service = KidImagesService();
  List<String?> chosenImages = [];
  List<KidImageModel> kidPhotosToCheck = [];
  bool hasError = false;
  bool isLoading = false;

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
      print('*****************IMAGES TO SEND********************');
      print(imagesToSend);

      print('*****************IMAGES TO SEND********************');
      bool success = await service.sendKidImage(childId, imagesToSend);
      if (success) {
        imagesToSend.clear();
        chosenImages.clear();
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getKidImagesToCheck(int childId) async {
    try {
      kidPhotosToCheck = await service.getKidPhotosToCheck(childId);
      hasError = service.hasError;
    } catch (e) {
      hasError = service.hasError;
      print(e);
    }
  }

  checkImage(int imageId) async {
    try {
      bool success = await service.checkImage(imageId);
      return success;
    } catch (e) {
      print(e);
    }
  }

  deleteImageCopy(int imageId)async{
    try {
      bool success = await service.deleteImageCopy(imageId);
      return success;
    } catch (e) {
      print(e);
    }
  }
}
