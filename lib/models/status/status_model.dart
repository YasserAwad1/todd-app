import 'package:json_annotation/json_annotation.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  final int? id;
  final String name;
  final List<SubStatusModel> substatus;

  StatusModel({
    this.id,
    required this.name,
    required this.substatus
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
  
}
