// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      image_cover: json['image_cover'] as String,
      event_images: (json['event_images'] as List<dynamic>)
          .map((e) => EventImagesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_cover': instance.image_cover,
      'event_images': instance.event_images,
    };
