import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/user/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel> getCurrentUser() async {
    try {
      final url = Uri.parse(Endpoints.currentUser);
      var token = locator.get<LocalRepo>().token;
      print(token);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final user = UserModel.fromJson(jsonResponse['user']);
      if (response.statusCode < 300) {
        return user;
      }
      throw Exception('error in getting user');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
