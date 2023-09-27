import 'package:json_annotation/json_annotation.dart';

part 'kid_model.g.dart';

@JsonSerializable()
class KidModel {
  final int? id;
  final String name;
  final String? image;
  final String? className;
  final String? gender;
  final int isExtra;

  KidModel({
    this.id,
    required this.name,
    required this.image,
    this.className,
    this.gender,
    required this.isExtra,
  });

  factory KidModel.fromJson(Map<String, dynamic> json) => _$KidModelFromJson(json);

  Map<String, dynamic> toJson() => _$KidModelToJson(this);
}
