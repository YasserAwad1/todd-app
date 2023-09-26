import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toddily_preschool/main/auth/service/auth_service.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';

class AuthProvider with ChangeNotifier {
  AuthService _service = AuthService();
  String errorMessage = '';
  final _localService = LocalRepo();
  // String? roleName;
  // bool isGuest = false;

  login(String userName, String password, BuildContext context) async {
    try {
      // if (userName.isEmpty || password.isEmpty) {
      //   return false;
      // }
      final success = await _service.logIn(userName, password, context);
      print(success);
      if (success) {
        print('********************PROVIDER TOKEN**********************');
        print(_service.token);
        print('********************PROVIDER TOKEN**********************');
        await locator.get<LocalRepo>().saveToken(_service.token!);
        // locator.get<LocalRepo>().saveRole(_service.role!);
        locator.get<LocalRepo>().vartoken(_service.token!);
        // locator.get<LocalRepo>().varRole(_service.role!);
        // roleName = locator.get<LocalRepo>().role;
        return true;
      }
      errorMessage = _service.errorMessage;
      return false;
    } catch (e) {
      print(e);
      throw Exception('error logging in');
    }
  }

  Future<bool> isTokenValid() async {
    // Make the HTTP request to the token validation endpoint
    var checkToken = await locator.get<LocalRepo>().getToken();
    // roleName = await locator.get<LocalRepo>().getRole();
    print('*************check TOken***********');
    print(checkToken);
    // print(roleName);
    print('*************check TOken***********');
    print('I AM GETTING HERE');
    final response = await http.get(
      Uri.parse(Endpoints.baseUrl),
      headers: {'Authorization': 'Bearer $checkToken'},
    );
    print('*********************isTokenValid*****************');
    // print(isTokenValid);
    print(response.statusCode);
    print('*********************isTokenValid*****************');

    // Check the response status code
    if (response.statusCode >= 300 || checkToken == null) {
      return false;
    } else {
      return true;
    }
  }

  logOut() async {
    try {
      final success = await _service.logout();
      await _localService.deleteValue('token');
      await _localService.deleteValue('role');
      await _localService.deleteValue('language');
      // await _localService.deleteValue('device_token');
      locator.get<LocalRepo>().token = null;
      notifyListeners();
      return success;
    } catch (e) {
      return false;
    }
  }
}
