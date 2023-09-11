import 'package:json_annotation/json_annotation.dart';

part 'sub_status_model.g.dart';

@JsonSerializable()
class SubStatusModel {
  final String? name;
  String? description;
  final String? image;
  final int? id;
  final int? statusId;

  SubStatusModel({
    this.name,
    this.description,
    this.image,
    this.id,
    this.statusId,
  });

  factory SubStatusModel.fromJson(Map<String, dynamic> json) => _$SubStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubStatusModelToJson(this);
}
