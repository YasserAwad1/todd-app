import 'package:toddily_preschool/models/status/toSendModels/status_to_send_model.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

class SendStatusModel {
  final int childId;
  final List<SubStatusModel> subStatuses;

  SendStatusModel({
    required this.childId,
    required this.subStatuses,
  });

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'substatus': subStatuses.map((e) => e.toJson()).toList(),
    };
  }
}
