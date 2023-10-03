import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:toddily_preschool/main/social_media_expert/service/kid_images_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class KidImageProvider with ChangeNotifier {
  KidImagesService service = KidImagesService();
  List<String?> chosenImages = [];
  List<KidImageModel> kidPhotosToCheck = [];
  List<KidImageModel> kidPhotosForParents = [];
  bool hasError = false;
  bool isLoading = false;

  sendKidImages(
    int childId,
  ) async {
    try {
      List<XFile?> imagesToSend = [];
      if (chosenImages.isNotEmpty) {
        for (int i = 0; i < chosenImages.length; i++) {
          final filePath = File(chosenImages[i]!).absolute.path;
          final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
          final splitted = filePath.substring(0, (lastIndex));
          final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
          var result = await FlutterImageCompress.compressAndGetFile(
            File(chosenImages[i]!).absolute.path,
            outPath,
            quality: 95,
          );
          imagesToSend.add(result);
        }
      }
      // print('*****************IMAGES TO SEND********************');
      // print(imagesToSend);

      // print('*****************IMAGES TO SEND********************');
      bool success = await service.sendKidImage(childId, imagesToSend);
      if (success) {
        imagesToSend.clear();
        chosenImages.clear();
      }
      return success;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<void> getKidImagesToCheck(int childId) async {
    try {
      kidPhotosToCheck = await service.getKidPhotosToCheck(childId);
      hasError = service.hasError;
    } catch (e) {
      hasError = service.hasError;
      // print(e);
    }
  }

  Future<void> getChildImagesForParents(int childId) async {
    try {
      kidPhotosForParents = await service.getChildImagesForParents(childId);
      hasError = service.hasError;
    } catch (e) {
      hasError = service.hasError;
      // print(e);
    }
  }

  checkImage(int imageId) async {
    try {
      bool success = await service.checkImage(imageId);
      return success;
    } catch (e) {
      // print(e);
    }
  }

  deleteImageCopy(int imageId) async {
    try {
      bool success = await service.deleteImageCopy(imageId);
      return success;
    } catch (e) {
      // print(e);
    }
  }
}
