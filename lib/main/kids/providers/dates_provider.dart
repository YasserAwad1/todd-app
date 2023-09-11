import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/kids/service/dates_service.dart';
import 'package:toddily_preschool/models/dates/date_model.dart';

class DatesProvider with ChangeNotifier {
  List<DateModel> dates = [];
  DatesService _service = DatesService();
  bool hasError = false;
  bool isLoading = false;

  getDatesByChildId(int childId) async {
    try {
      isLoading = true;
      dates = await _service.getDatesOfStatuses(childId);
      hasError = _service.hasError;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      hasError = _service.hasError;
      notifyListeners();
    }
  }
}
