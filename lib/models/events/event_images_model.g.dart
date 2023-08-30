// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventImagesModel _$EventImagesModelFromJson(Map<String, dynamic> json) =>
    EventImagesModel(
      id: json['id'] as int?,
      event_id: json['event_id'] as int?,
      src: json['src'] as String,
    );

Map<String, dynamic> _$EventImagesModelToJson(EventImagesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.event_id,
      'src': instance.src,
    };
