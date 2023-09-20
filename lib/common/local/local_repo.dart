import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {
  String? token;
  String? role;
  String? language;
  String? deviceToken;

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    return token;
  }

  saveDeviceToken(String deviceToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_token', deviceToken);
  }

  getDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceToken = prefs.getString('device_token');

    return deviceToken;
  }

  setLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  getLanguage() async {
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

  deleteValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    prefs.remove('token');
    prefs.remove('role');
    prefs.remove('language');
  }
}
