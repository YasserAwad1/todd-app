import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {
  String? token;
  String? role;
  String? language;

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    return token;
  }

  setLanguage(String languageCode) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  getLanguage()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language');

    return language;
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
