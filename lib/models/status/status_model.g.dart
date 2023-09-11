// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      name: json['name'] as String?,
      id: json['id'] != null ? json['id'] as int? : null,
      substatus: (json['substatus'] as List<dynamic>)
          .map((e) => SubStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'substatus': instance.substatus,
      if(instance.id != null) 'id': instance.id
    };
