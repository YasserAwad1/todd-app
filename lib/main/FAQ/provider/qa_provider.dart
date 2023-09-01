import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/FAQ/service/qa_service.dart';
import 'package:toddily_preschool/models/Q&A/qa_model.dart';

class QaProvider with ChangeNotifier {
  QAService _service = QAService();
  List<QaModel> qaList = [];

  getQuestionsAndAnswers() async {
    qaList = await _service.getQA();
  }
}
