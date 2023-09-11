import 'package:json_annotation/json_annotation.dart';

part 'kid_image_model.g.dart';


@JsonSerializable()
class KidImageModel {
  final int? id;
  final int? childId;
  final String? image;
  final bool? isImageChecked;

  KidImageModel({
    this.id,
    this.childId,
    this.image,
    this.isImageChecked,
  });

  factory KidImageModel.fromJson(Map<String, dynamic> json) => _$KidImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$KidImageModelToJson(this);
}
