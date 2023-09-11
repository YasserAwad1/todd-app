import 'package:json_annotation/json_annotation.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  final String? name;
  final int? id;
  final List<SubStatusModel>? substatus;

  StatusModel({
    this.name,
    this.substatus,
    this.id,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
