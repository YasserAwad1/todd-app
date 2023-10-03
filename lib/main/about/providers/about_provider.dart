import 'package:flutter/cupertino.dart';
import 'package:toddily_preschool/main/about/service/about_service.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';

class AboutProvider with ChangeNotifier {
  AboutService service = AboutService();
  List<PhotoModel> aboutImages = [];
  bool hasError = false;

  getPhotos() async {
    try {
      aboutImages = await service.getPhotos();
      hasError = service.hasError;
    } catch (e) {
      hasError = service.hasError;
      // print(e);
      rethrow;
    }
  }
}
