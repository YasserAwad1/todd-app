import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/dates/date_model.dart';
import 'package:http/http.dart' as http;
import 'package:toddily_preschool/models/kids/kid_model.dart';

class DatesService {
  var token = locator.get<LocalRepo>().token;
  bool hasError = false;

  Future<List<DateModel>> getDatesOfStatuses(int childId) async {
    try {
      final url = Uri.parse('${Endpoints.dates}/$childId');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization':
            'Bearer $token'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        List<DateModel> dates = (jsonResponse['data'] as List)
            .map(
              (e) => DateModel.fromJson(e),
            )
            .toList();
            hasError = false;
        return dates;
      } else {
        hasError = true;
        throw Exception('error in getting dates');
      }
    } catch (e) {
      print(e);
       hasError = true;
      rethrow;
    }
  }
}
