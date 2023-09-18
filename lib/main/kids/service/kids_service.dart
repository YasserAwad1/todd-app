import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:http/http.dart' as http;

class KidsService {
  bool hasError = false;

  Future<List<KidModel>> getKidsByTeachOrParentId(int userId) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url =
          Uri.parse('${Endpoints.getChildrenByParentOrTeacherId}/$userId');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print('***************KIDS SERVICE***************');
        print(jsonResponse);
        print('***************KIDS SERVICE***************');
        List<KidModel> kids = (jsonResponse['children'] as List)
            .map(
              (e) => KidModel.fromJson(e),
            )
            .toList();
        print(kids);
        hasError = false;
        return kids;
      } else {
        hasError = true;
        throw Exception('error in getting dates');
      }
    } catch (e) {
      print(e);
      hasError = true;
      throw Exception('error in getting kids by teacher or parent id');
    }
  }

  Future<List<KidModel>> getExtrasChildren() async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse(Endpoints.getExtrasChildren);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print('***************EXTRA KIDS SERVICE***************');
        print(jsonResponse);
        print('***************EXTRA KIDS SERVICE***************');
        List<KidModel> kids = (jsonResponse['children'] as List)
            .map(
              (e) => KidModel.fromJson(e),
            )
            .toList();
        print(kids);
        hasError = false;
        return kids;
      } else {
        hasError = true;
        throw Exception('error in getting extra children');
      }
    } catch (e) {
      print(e);
      hasError = true;
      throw Exception('error in getting extra children');
    }
  }
}
