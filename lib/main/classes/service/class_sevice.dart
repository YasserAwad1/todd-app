import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/classes/class_model.dart';

class ClassService {
  var token = locator.get<LocalRepo>().token;

  Future<List<ClassModel>> getClasses() async {
    try {
      final url = Uri.parse(Endpoints.classes);

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });

      // print(jsonDecode(response.body));

      if (response.statusCode == 202) {
        final jsonResponse = jsonDecode(response.body);
        final classes = (jsonResponse as List)
            .map(
              (e) => ClassModel.fromJson(e),
            )
            .toList();

        return classes;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ClassModel?> getClassById(int id) async {
    try {
      final url = Uri.parse('${Endpoints.classes}/$id');

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final classById = ClassModel.fromJson(jsonResponse['class']);

        return classById;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
