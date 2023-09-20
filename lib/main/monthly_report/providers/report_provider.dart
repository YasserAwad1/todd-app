import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/monthly_report/service/report_service.dart';
import 'package:toddily_preschool/models/report/report_model.dart';

class ReportProvider with ChangeNotifier {
  ReportService _service = ReportService();
  List<ReportModel> reports = [];
  bool isLoading = false;
  bool hasError = false;

  getChildReport(int childId) async {
    try {
      isLoading = true;
      reports = await _service.getChildReports(childId);
      hasError = _service.hasError;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      hasError = _service.hasError;
      print('ERROR IN GETTING REPORTS');
      rethrow;
    }
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

  updateReport(int childId, int reportId, String newDescription) async {
    try {
      bool success =
          await _service.updateReport(childId, reportId, newDescription);
      return success;
    } catch (e) {
      print(e);
    }
  }

  Future<bool>deleteReport(int reportId) async {
    try {
      bool success = await _service.deleteReport(reportId);
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
