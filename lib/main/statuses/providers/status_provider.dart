import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/statuses/service/status_service.dart';
import 'package:toddily_preschool/models/status/status_model.dart';

class StatusProvider with ChangeNotifier {
  final StatusService _service = StatusService();
  List<StatusModel> statuses = [];
  List<StatusModel> childStatusesByDate = [];

  getStatuses() async {
    await _service.getStatuses();
  }

  getChildStatusByDate(int childId, String date) async {
    try {
      childStatusesByDate = await _service.getChildStatusByDate(
        childId,
        date,
      );
    } catch (e) {
      print(e);
    }
  }

  sendStatus(int childId, List<StatusModel> statusList) async {
    await _service.sendStatus(childId, statusList);
  }
}
