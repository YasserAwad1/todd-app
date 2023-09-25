import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/photos/service/photos_service.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';

class PhotosProvider with ChangeNotifier {
  PhotosService _service = PhotosService();
  List<PhotoModel> photos = [];
  bool isList = false;
  bool hasError = false;

  changeListGridView() {
    isList = !isList;
    notifyListeners();
  }

  Future<void> getPhotos() async {
    try {
      photos = await _service.getPhotos();
      hasError = _service.hasError;
    } catch (e) {
      hasError = _service.hasError;
      print(e);
      rethrow;
    }
  }
}
