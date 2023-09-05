import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final int role_id;
  final String name;
  final String username;
  final String phone;

  UserModel({
    this.id,
    required this.role_id,
    required this.name,
    required this.username,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
