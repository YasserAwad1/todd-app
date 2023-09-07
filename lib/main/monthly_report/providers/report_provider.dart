import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/monthly_report/service/report_service.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class ReportProvider with ChangeNotifier {
  ReportService _service = ReportService();
  List<ReportModel> reports = [];
  bool isLoading = false;

  getChildReport(int childId) async {
    isLoading = true;
    reports = await _service.getChildReports(childId);
    isLoading = false;
    notifyListeners();
  }

  sendReport(int childId, String description) async {
    try {
      bool success = await _service.sendReport(childId.toString(), description);
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
