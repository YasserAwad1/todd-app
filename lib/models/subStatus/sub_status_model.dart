import 'package:json_annotation/json_annotation.dart';

part 'sub_status_model.g.dart';

@JsonSerializable()
class SubStatusModel {
  final int? id;
  final int? statusId;
  final String name;
  final String? description;

  SubStatusModel({
    this.id,
    this.statusId,
    required this.name,
    this.description,
  });

  factory SubStatusModel.fromJson(Map<String, dynamic> json) => _$SubStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubStatusModelToJson(this);
}
