// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubStatusModel _$SubStatusModelFromJson(Map<String, dynamic> json) =>
    SubStatusModel(
        name: json['name'] as String,
        description: json['description'] as String?,
        image: json['image'] as String,
        id: json['id'] != null ? json['id'] as int? : null,
        statusId: json['status_id'] != null ? json['status_id'] as int? : null);

Map<String, dynamic> _$SubStatusModelToJson(SubStatusModel instance) =>
    <String, dynamic>{
      'substatus_id': instance.id,
      'description': instance.description,
    };
