import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/statuses/service/status_service.dart';
import 'package:toddily_preschool/models/status/status_model.dart';

class StatusProvider with ChangeNotifier {
  final StatusService _service = StatusService();
  List<StatusModel> statuses = [];

  getStatuses() async {
    await _service.getStatuses();
  }

  sendStatus(int childId, List<StatusModel> statusList) async {
    await _service.sendStatus(childId, statusList);
  }
  
}
