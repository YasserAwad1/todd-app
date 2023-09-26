import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthService {
  Map<String, String> headers = {"Accept": "application/json"};
  String? token;
  String? role;
  String errorMessage = "";

  Future<bool> logIn(
      String userName, String password, BuildContext context) async {
    try {
      if (userName.isEmpty || password.isEmpty) {
        errorMessage = AppLocalizations.of(context)!.allFeildsAreReq;
        return false;
      }
      var deviceToken = await locator.get<LocalRepo>().getDeviceToken();
      final url = Uri.parse(Endpoints.login);
      final response = await http.post(
        url,
        body: {
          "username": userName,
          "password": password,
          "device_token": deviceToken
        },
      );
      print(response.statusCode);
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode >= 500) {
        errorMessage = AppLocalizations.of(context)!.networkError;
        return false;
      } else if (response.statusCode == 422) {
        errorMessage = AppLocalizations.of(context)!.invalidCredentials;
        return false;
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        token = jsonResponse['token'];
        role = jsonResponse['user']['role'];
        return true;
      }
      errorMessage = AppLocalizations.of(context)!.errorOccured;
      return false;
    } on SocketException catch (e) {
      errorMessage = AppLocalizations.of(context)!.errorOccured;
      return false;
    } on TimeoutException catch (e) {
      errorMessage = AppLocalizations.of(context)!.errorOccured;
      return false;
    } catch (e) {
      print(e);
      rethrow;
      // return false;
    }
  }

  Future<bool> logout() async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse(Endpoints.logout);
      final response = await http.post(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode < 300) {
        return true;
      } else {
        errorMessage = 'Error logging out';
        return false;
      }
    } catch (e) {
      errorMessage = 'Error logging out';
      throw Exception('error logging out');
    }
  }
}
