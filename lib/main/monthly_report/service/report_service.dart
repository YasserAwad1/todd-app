import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/report/report_model.dart';
import 'package:http/http.dart' as http;

class ReportService {
  bool hasError = false;

  Future<List<ReportModel>> getChildReports(int childId) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse('${Endpoints.getChildReports}/$childId');

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        final reports = (jsonResponse['reports'] as List)
            .map(
              (e) => ReportModel.fromJson(e),
            )
            .toList();
        hasError = false;
        return reports;
      } else {
        hasError = true;
        throw Exception('error in getting reports');
      }
    } catch (e) {
      hasError = true;
      print(e);
      rethrow;
    }
  }

  Future<bool> sendReport(String childId, String description) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse(Endpoints.report);

      final response = await http.post(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "child_id": childId,
        "description": description
      });
      print(response.body);
      if (response.statusCode < 300) {
        print('REPORT SENT');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateReport(
    int childId,
    int reportId,
    String newDescription,
  ) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse('${Endpoints.report}/$reportId');

      final response = await http.put(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "child_id": childId.toString(),
        "description": newDescription.toString()
      });
      print(response.body);
      if (response.statusCode < 300) {
        print('REPORT Updated');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteReport(
    int reportId,
  ) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse('${Endpoints.report}/$reportId');

      final response = await http.delete(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      print(response.body);
      if (response.statusCode < 300) {
        print('REPORT Updated');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
