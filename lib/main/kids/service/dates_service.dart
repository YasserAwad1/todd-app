import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/dates/date_model.dart';
import 'package:http/http.dart' as http;

class DatesService {
  Future<List<DateModel>> getDatesOfStatuses(int childId) async {
    try {
      final url = Uri.parse('${Endpoints.dates}/$childId');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization':
            'Bearer 19|laravel_sanctum_v6czqR3mI46ykpbpdWQZgT2HrPLxrGyIW9df8pSlb231d926'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        List<DateModel> dates = (jsonResponse['data'] as List)
            .map(
              (e) => DateModel.fromJson(e),
            )
            .toList();
        return dates;
      } else {
        throw Exception('error in getting dates');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
