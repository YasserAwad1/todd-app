import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  final int? id;
  final String image_url;

  PhotoModel({
    this.id,
    required this.image_url,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}
