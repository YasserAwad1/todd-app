import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {
  String? token;
  String? role;

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    return token;
  }

  vartoken(String token2) {
    token = token2;
  }

  saveRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

   getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');

    return role;
  }

  varRole(String role2) {
    role = role2;
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
