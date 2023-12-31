import 'package:flutter/material.dart';
import 'package:toddily_preschool/common/user/service/user_service.dart';
import 'package:toddily_preschool/models/user/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  int? roleId;
  int? id;
  UserService _service = UserService();

  getCurrentUser() async {
    try {
      currentUser = await _service.getCurrentUser();
      // print('******************role ID*****************');
      // print(currentUser!.role_id);
      // print('******************role ID*****************');
    } catch (e) {
      // print(e);
      throw Exception('error in get current user');
    }
  }

  int? getCurrentUserId() {
    return currentUser!.id;
  }

  assignGuest() {
    currentUser = UserModel(
      name: 'guest',
      phone: 'guest',
      role_id: 7,
      username: 'guest',
    );
  }

  deleteGuest() {
    currentUser = null;
    notifyListeners();
  }

  int? getUserRoleId() {
    return currentUser!.role_id;
  }

  bool classesTile() {
    if (currentUser!.role_id == 1 ||
        currentUser!.role_id == 3 ||
        currentUser!.role_id == 4) {
      return true;
    }
    return false;
  }

  bool kidsTile() {
    if (currentUser!.role_id == 2 ||
        currentUser!.role_id == 5 ||
        currentUser!.role_id == 6) {
      return true;
    }
    return false;
  }

  bool teacherOrParent() {
    if (currentUser!.role_id == 2 || currentUser!.role_id == 5) {
      return true;
    }
    return false;
  }

  bool teacherOrExtra() {
    if (currentUser!.role_id == 2 || currentUser!.role_id == 6) {
      return true;
    }
    return false;
  }

  bool forDatesScreen() {
    if (currentUser!.role_id == 1 ||
        currentUser!.role_id == 5 ||
        currentUser!.role_id == 6 ||
        currentUser!.role_id == 2) {
      return true;
    }
    return false;
  }

  bool reportButton() {
    if (currentUser!.role_id == 1 || currentUser!.role_id == 5) {
      return true;
    }
    return false;
  }
}
