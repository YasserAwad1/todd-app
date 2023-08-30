import 'package:json_annotation/json_annotation.dart';
import 'package:toddily_preschool/models/events/event_images_model.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  final int? id;
  final String name;
  final String image_cover;
  final List<EventImagesModel> event_images;

  EventModel({
    this.id,
    required this.name,
    required this.image_cover,
    required this.event_images,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
