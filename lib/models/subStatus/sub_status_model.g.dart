// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubStatusModel _$SubStatusModelFromJson(Map<String, dynamic> json) =>
    SubStatusModel(
      id: json['id'] as int?,
      statusId: json['statusId'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SubStatusModelToJson(SubStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statusId': instance.statusId,
      'name': instance.name,
      'description': instance.description,
    };
