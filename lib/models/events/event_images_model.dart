import 'package:json_annotation/json_annotation.dart';

part 'event_images_model.g.dart';

@JsonSerializable()
class EventImagesModel {
  final int? id;
  final int? event_id;
  final String src;

  EventImagesModel({
    this.id,
    this.event_id,
    required this.src,
  });

  factory EventImagesModel.fromJson(Map<String, dynamic> json) => _$EventImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventImagesModelToJson(this);
}