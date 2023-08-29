// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KidModel _$KidModelFromJson(Map<String, dynamic> json) => KidModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      image: json['image'] as String?,
      isExtra: json['isExtra'] as int,
      parent_id: json['parent_id'] as int,
      classRoom_id: json['classRoom_id'] as int,
    );

Map<String, dynamic> _$KidModelToJson(KidModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'isExtra': instance.isExtra,
      'parent_id': instance.parent_id,
      'classRoom_id': instance.classRoom_id,
    };
