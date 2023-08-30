// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoListModel _$PhotoListModelFromJson(Map<String, dynamic> json) =>
    PhotoListModel(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhotoListModelToJson(PhotoListModel instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };
