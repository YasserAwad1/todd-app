import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:toddily_preschool/models/Q&A/qa_list.dart';
import 'package:toddily_preschool/models/Q&A/qa_model.dart';

class QAService {
  bool hasError = false;
  Future<List<QaModel>> getQA() async {
    try {
      final url = Uri.parse(Endpoints.qa);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['qa']);
        final qas = (jsonResponse['qa'] as List)
            .map(
              (e) => QaModel.fromJson(e),
            )
            .toList();
        print(qas);
        hasError = false;
        return qas;
      } else {
        hasError = true;
        throw Exception('Erro in getting FAQs');
      }
    } catch (e) {
      print(e);
      hasError = true;
      rethrow;
    }
  }
}
