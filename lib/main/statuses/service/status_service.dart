import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/status/status_model.dart';
import 'package:http/http.dart' as http;

class StatusService {
  var token = locator.get<LocalRepo>().token;

  Future<List<StatusModel>> getStatuses() async {
    try {
      final url = Uri.parse(Endpoints.statuses);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print('****************status RESPONSE************');
        print(jsonResponse[0]);
        print('****************status RESPONSE************');
        final statuses = (jsonResponse as List)
            .map(
              (e) => StatusModel.fromJson(e),
            )
            .toList();

        return statuses;
      } else {
        print('error');
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<StatusModel>> getChildStatusByDate(
      int childId, String date) async {
    try {
      final url = Uri.parse('${Endpoints.childStatusByDate}/$childId');

      final response = await http.post(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "date": date,
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print('****************CHILD status RESPONSE************');
        print(jsonResponse['status']);
        print('****************CHILD status RESPONSE************');
        final statuses = (jsonResponse['status'] as List)
            .map(
              (e) => StatusModel.fromJson(e),
            )
            .toList();
        print(statuses);

        return statuses;
      } else {
        print('error');
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> sendStatus(int childId, List<StatusModel> statuses) async {
    try {
      final url = Uri.parse(Endpoints.sendStatus);
      final response = await http.post(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "child_id": childId,
        "status": jsonEncode(
          statuses.map((status) => status.toJson()).toList(),
        )
      });
      if (response.statusCode < 300) {
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
