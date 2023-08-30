import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_list_model.g.dart';

@JsonSerializable()
class PhotoListModel {
  List<PhotoModel> posts;

  PhotoListModel({
    required this.posts,
  });

  factory PhotoListModel.fromJson(Map<String, dynamic> json) => _$PhotoListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoListModelToJson(this);
}
