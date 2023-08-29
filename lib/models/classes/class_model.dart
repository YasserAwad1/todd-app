import 'package:toddily_preschool/models/kids/kid_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class_model.g.dart';

@JsonSerializable()
class ClassModel {
  final int? id;
  final String name;
  final List<KidModel> children;

  ClassModel({
    this.id,
    required this.name,
    required this.children,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => _$ClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}
