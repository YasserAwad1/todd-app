import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CameraProvider with ChangeNotifier{
  List<XFile> _capturedImages = [];

  void addImages(XFile image){
    _capturedImages.add(image);
    notifyListeners();
  }

  List<XFile> getTakenImages(){
    return _capturedImages;
  }
}