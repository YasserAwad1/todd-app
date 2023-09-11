import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toddily_preschool/common/constants/end_points.dart';

class AuthService {
  Map<String, String> headers = {"Accept": "application/json"};
  String? token;
  String? role;

  Future<bool> logIn(String userName, String password) async {
    try {
      final url = Uri.parse(Endpoints.login);
      final response = await http.post(
        url,
        body: {
          "username": userName,
          "password": password,
        },
      );
      print(response.statusCode);
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode < 300) {
        token = jsonResponse['token'];
        role = jsonResponse['user']['role'];
        // print('*************class id *******************');
        // print(jsonResponse['user']['class']['id']);
        // print('*************class id *******************');
        // print(jsonResponse['token']);
        // print('good');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
      // return false;
    }
  }
}
