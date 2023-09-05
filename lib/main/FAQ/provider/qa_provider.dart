import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/FAQ/service/qa_service.dart';
import 'package:toddily_preschool/models/Q&A/qa_model.dart';

class QaProvider with ChangeNotifier {
  QAService _service = QAService();
  List<QaModel> qaList = [];
  bool hasError = false;

  getQuestionsAndAnswers() async {
    try {
      qaList = await _service.getQA();
      hasError = _service.hasError;
    } catch (e) {
      hasError = _service.hasError;
      rethrow;
    }
  }
}
