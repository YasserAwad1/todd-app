import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/kids/service/dates_service.dart';
import 'package:toddily_preschool/models/dates/date_model.dart';

class DatesProvider with ChangeNotifier {
  List<DateModel> dates = [];
  DatesService _service = DatesService();

  getDatesByChildId(int childId) async {
    dates = await _service.getDatesOfStatuses(childId);
  }
}
