import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/classes/class_model.dart';

class ClassService {
  String? message;
  bool hasError = false;

  Future<List<ClassModel>> getClasses() async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse(Endpoints.classes);

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });


      // print('******************classes***************');
      // print(response.statusCode);
      // print(jsonDecode(response.body));
      // print('******************classes***************');

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        
        final classes = (jsonResponse as List)
            .map(
              (e) => ClassModel.fromJson(e),
            )
            .toList();
        hasError = false;
        // print(classes);

        return classes;
      } else {
        message = 'Something Went wrong, please try again.';
        hasError = true;
        throw Exception('error in getting classes');
      }
    } catch (e) {
      message = 'Something Went wrong, please try again.';
      hasError = true;
      // print(e);
      rethrow;
    }
  }

  Future<ClassModel?> getClassById(int id) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse('${Endpoints.classes}/$id');

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        final classById = ClassModel.fromJson(jsonResponse['class']);

        return classById;
      } else {
        return null;
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
