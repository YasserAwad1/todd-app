import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/statuses/service/status_service.dart';
import 'package:toddily_preschool/models/status/status_model.dart';
import 'package:toddily_preschool/models/status/toSendModels/status_to_send_model.dart';
import 'package:toddily_preschool/models/status/toSendModels/subStatus_to_send_model.dart';
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
    print('sending');
    try {
      var success = await _service.sendStatus(childId, substatusListFromScreen);
      return success;
    } catch (e) {
      print(e);
      print('error in sending substatus');
      return false;
      // throw Exception('ERROR IN SENDING SUBSTATUS');
    }
  }

  // createStatusListFromSubstatusList(int childId) async {
  //   List<StatusModel> statusList = [];
  //   List<StatusToSendModel> statusesToSend = [];
  //   List<SubStatusToSendModel> subStatusesToSend = [];
  //   bool success = false;

  //   for (SubStatusModel substatus in substatusListFromScreen) {
  //     bool addedToExistingStatus = false;

  //     for (StatusModel status in statusList) {
  //       if (status.id == substatus.statusId) {
  //         status.substatus!.add(substatus);
  //         addedToExistingStatus = true;
  //         break;
  //       }
  //     }

  //     if (!addedToExistingStatus) {
  //       StatusModel newStatus = StatusModel(
  //         id: substatus.statusId,
  //         // statusId: substatus.statusId,
  //         substatus: [substatus],
  //       );
  //       statusList.add(newStatus);
  //     }
  //   }
  //   for (int i = 0; i < statusList.length; i++) {
  //     for (int j = 0; j < statusList[i].substatus!.length; j++) {
  //       subStatusesToSend.add(
  //         SubStatusToSendModel(
  //           subStatusId: statusList[i].substatus![j].id!,
  //           description: statusList[i].substatus![j].description
  //         ),
  //       );
  //     }
  //     statusesToSend.add(StatusToSendModel(
  //       statusId: statusList[i].id!,
  //       // name: statusList[i].name!,
  //       substatus: subStatusesToSend,
  //     ));
  //     // print('****************STATUSES TO SEND*******************');
  //     // print(statusesToSend[1].statusId);
  //     // print('****************STATUSES TO SEND*******************');
  //   }
  //   try {
  //     success = await _service.sendStatus(
  //       childId,
  //       statusesToSend,
  //     );
  //     return success;
  //   } catch (e) {
  //     print(e);
  //     throw Exception('error in sending statuses');
  //   }
  // }

  getChildStatusByDate(int childId, String date) async {
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

  getStatusesToSend(int childId) async {
    try {
      statusesToSendList = await _service.getStatusesToSend(childId);
      hasError = _service.hasError;
    } catch (e) {
      print(e);
      hasError = _service.hasError;
    }
  }

  testStatus() async {
    try {
      var success = await _service.statusTest();
      print('STATUS TEST $success');
    } catch (e) {
      print(e);
      throw Exception('error in test status');
    }
  }

  // sendStatus(int childId, List<StatusesTo> statusList) async {
  //   await _service.sendStatus(childId, statusList);
  // }
}
