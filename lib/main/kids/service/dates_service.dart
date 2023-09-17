import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/dates/date_model.dart';
import 'package:http/http.dart' as http;
import 'package:toddily_preschool/models/kids/kid_model.dart';

class DatesService {
  bool hasError = false;

  Future<List<DateModel>> getDatesOfStatuses(int childId) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse('${Endpoints.dates}/$childId');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print('***************jsonResponse***********');
        print(jsonResponse['data']);
        print('***************jsonResponse***********');
        // var data = jsonResponse['data'];
        // print(
        //   data.values.map((map) => map['date']).toList(),
        // );
        // print(data);
        // var datesFromBack = data.values.map((map) => map['date']).toList();
        // print('***************datesFromBack***********');
        // print(datesFromBack);
        // print('***************datesFromBack***********');
        // List<DateModel> dates = datesFromBack
        //     .map((dateString) => DateModel(date: dateString))
        //     .toList();
        // print('***************DATES***********');
        // print(dates);
        // print('***************DATES***********');
        List<DateModel> dates = (jsonResponse['data'] as List)
            .map(
              (e) => DateModel.fromJson(e),
            )
            .toList();
          print(dates);
        hasError = false;
        //     print(dates[0]);
        return dates;
      } else {
        hasError = true;
        throw Exception('error in getting dates');
      }
    } catch (e) {
      print('***********************DATES SERVICE**********************');
      print(e);
      print('***********************DATES SERVICE**********************');
      hasError = true;
      rethrow;
    }
  }
}
