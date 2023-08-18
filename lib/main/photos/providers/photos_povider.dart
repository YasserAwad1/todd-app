import 'package:flutter/material.dart';

class PhotosProvider with ChangeNotifier {
  bool isList = true;
  bool isPhotosScreen= false;
  bool isEventsScreen = false;

  changeListGridView() {
    isList = !isList;
    notifyListeners();
  }

  triggerPhotosScreen(){
    isPhotosScreen = true;
    isEventsScreen = false;
    notifyListeners();
  }

  triggerEventsScreen(){
    isEventsScreen = true;
    isPhotosScreen = false;
    notifyListeners();
  }


}
