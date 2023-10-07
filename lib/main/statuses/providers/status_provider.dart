import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/statuses/service/status_service.dart';
import 'package:toddily_preschool/models/status/status_model.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

class StatusProvider with ChangeNotifier {
  final StatusService _service = StatusService();
  List<StatusModel> childStatusesByDate = [];
  List<StatusModel> statusesToSendList = [];
  List<SubStatusModel> substatusListFromScreen = [];
  bool hasError = false;

  // getStatuses() async {
  //   await _service.getStatuses();
  // }

  addSubStatusFromScreen(SubStatusModel substatus) {
    substatusListFromScreen.add(substatus);
    notifyListeners();
  }

  removeSubStatusFromScreen(SubStatusModel substatus) {
    substatusListFromScreen.remove(substatus);
    notifyListeners();
  }

  bool isSubstatusInList(int id) {
    bool isInList =
        substatusListFromScreen.any((subStatus) => subStatus.id == id);
    return isInList;
  }

  bool appearSendButton() {
    if (substatusListFromScreen.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  sendStatus(int childId) async {
    // print('sending');
    try {
      var success = await _service.sendStatus(childId, substatusListFromScreen);
      return success;
    } catch (e) {
      // print(e);
      // print('error in sending substatus');
      return false;
      // throw Exception('ERROR IN SENDING SUBSTATUS');
    }
  }


  Future<void> getChildStatusByDate(int childId, String date) async {
    try {
      childStatusesByDate = await _service.getChildStatusByDate(
        childId,
        date,
      );
      hasError = _service.hasError;
    } catch (e) {
      print(e);
      hasError = _service.hasError;
    }
  }

  Future<void> getStatusesToSend(int childId) async {
    try {
      statusesToSendList = await _service.getStatusesToSend(childId);
      hasError = _service.hasError;
    } catch (e) {
      print(e);
      hasError = _service.hasError;
    }
  }

}
