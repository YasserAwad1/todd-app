import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/classes/service/class_sevice.dart';
import 'package:toddily_preschool/models/classes/class_model.dart';

class ClassProvider with ChangeNotifier {
  final ClassService _service = ClassService();
  List<ClassModel> classes = [];
  ClassModel? classById;
  String? message;
  bool hasError = false;

  Future<void> getClasses() async {
    try {
      classes = await _service.getClasses();
      hasError = _service.hasError;
    } catch (e) {
      message = _service.message;
      hasError = _service.hasError;
      print(e);
      rethrow;
    }
  }

  getClassById(int id) async {
    try {
      return classById = await _service.getClassById(id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
