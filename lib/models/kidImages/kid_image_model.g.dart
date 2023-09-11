// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KidImageModel _$KidImageModelFromJson(Map<String, dynamic> json) =>
    KidImageModel(
      id: json['id'] as int?,
      childId: json['child_id'] as int?,
      image: json['image'] as String?,
      // isImageChecked: json['isImageChecked'] as bool?,
    );

Map<String, dynamic> _$KidImageModelToJson(KidImageModel instance) =>
    <String, dynamic>{
      // 'id': instance.id,
      'child_id': instance.childId,
      'image': instance.image,
      // 'teacher_checked': instance.isImageChecked,
    };
