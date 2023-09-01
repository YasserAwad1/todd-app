import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/photos/service/photos_service.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';

class PhotosProvider with ChangeNotifier {
  PhotosService _service = PhotosService();
  List<PhotoModel> photos = [];
  bool isList = true;

  changeListGridView() {
    isList = !isList;
    notifyListeners();
  }

  getPhotos() async {
    photos = await _service.getPhotos();
  }
}
