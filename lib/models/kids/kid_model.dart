import 'package:json_annotation/json_annotation.dart';

part 'kid_model.g.dart';

@JsonSerializable()
class KidModel {
  final int? id;
  final String name;
  final String? image;
  final int isExtra;
  final int parent_id;
  final int classRoom_id;

  KidModel({
    this.id,
    required this.name,
    required this.image,
    required this.isExtra,
    required this.parent_id,
    required this.classRoom_id,
  });

  factory KidModel.fromJson(Map<String, dynamic> json) => _$KidModelFromJson(json);

  Map<String, dynamic> toJson() => _$KidModelToJson(this);
}
