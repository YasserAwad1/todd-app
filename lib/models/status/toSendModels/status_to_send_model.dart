// import 'package:json_annotation/json_annotation.dart';
import 'subStatus_to_send_model.dart';

// part 'status_to_send_model.g.dart';

// @JsonSerializable()
class StatusToSendModel {
  final int statusId;
  // final String? name;
  List<SubStatusToSendModel> substatus;

  StatusToSendModel({
    required this.statusId,
    // this.name,
    required this.substatus,
  });

  // Map<String,dynamic> ToJson(StatusToSendModel status) => {
  //   "status_id": status.statusId.toString(),
  //           "name": status.name,
  //           "substatus": substatus.,

  // }
  Map<String, dynamic> toJson() {
    return {
      "status_id": statusId,
      // if (name != null) "name": name!,
      "substatus": substatus.map((subStatus) => subStatus.toJson()).toList(),
    };
  }
}
