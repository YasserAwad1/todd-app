// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      role_id: json['role_id'] as int,
      // update for noor's problem
      // name: json['first_name'] as String,
      name: json['username'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'role_id': instance.role_id,
      'username': instance.name,
      // update for noor's problem
      // 'first_name': instance.username,
      'phone': instance.phone,
    };
