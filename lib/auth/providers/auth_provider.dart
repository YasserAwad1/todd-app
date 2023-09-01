import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/auth/service/auth_service.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';

class AuthProvider with ChangeNotifier {
  AuthService _service = AuthService();
  String? roleName;
  bool isGuest = false;

  login(String userName, String password) async {
    try {
      if (userName.isEmpty || password.isEmpty) {
        return false;
      }
      final success = await _service.logIn(userName, password);
      print(success);
      if (success) {
        locator.get<LocalRepo>().saveToken(_service.token!);
        locator.get<LocalRepo>().saveRole(_service.role!);
        locator.get<LocalRepo>().vartoken(_service.token!);
        locator.get<LocalRepo>().varRole(_service.role!);
        roleName = locator.get<LocalRepo>().role;
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  // assignRole() {
  //   roleName = locator.get<LocalRepo>().role;
  // }

  String getUserRole() {
    return roleName!;
  }

  bool classesTile() {
    if (roleName == 'admin' ||
        roleName == 'social' ||
        roleName == 'doctor' ) {
      return true;
    }
    return false;
  }

  bool kidsTile(){
    if (roleName == 'teacher' ||
        roleName == 'parent' ||
        roleName == 'extra' ) {
      return true;
    }
    return false;
  }

  bool forDatesScreen() {
    if (roleName == 'admin' ||
        roleName == 'social' ||
        roleName == 'parent' ||
        roleName == 'extra' ||
        roleName == 'teacher') {
      return true;
    }
    return false;
  }

  setGuest() {
    locator.get<LocalRepo>().saveRole('guest');
    locator.get<LocalRepo>().varRole('guest');
    roleName = 'guest';
    isGuest = true;
    notifyListeners();
  }

  Future<bool> isTokenValid() async {
    // Make the HTTP request to the token validation endpoint
    var checkToken = await locator.get<LocalRepo>().getToken();
    roleName = await locator.get<LocalRepo>().getRole();
    print('*************check TOken***********');
    print(checkToken);
    print(roleName);
    print('*************check TOken***********');
    final response = await http.get(
      Uri.parse(Endpoints.baseUrl),
      headers: {'Authorization': 'Bearer $checkToken'},
    );

    // Check the response status code
    if (response.statusCode >= 300 || checkToken == null) {
      return false;
    } else {
      return true;
    }
  }

  logOut() async {
    final _localService = LocalRepo();
    locator.get<LocalRepo>().token = null;
    var loggedOut = await _localService.clear();
    if (loggedOut) {
      return true;
    }
  }
}
