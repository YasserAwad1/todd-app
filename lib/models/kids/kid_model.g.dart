// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KidModel _$KidModelFromJson(Map<String, dynamic> json) => KidModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      image: json['image'] as String?,
      className: json['className'] != null ? json['className'] as String? : null,
      isExtra: json['isExtra'] as int,
    );

Map<String, dynamic> _$KidModelToJson(KidModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'isExtra': instance.isExtra,
      'className': instance.className,
    };
