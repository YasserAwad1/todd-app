// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['id'] as int?,
      child_id: json['child_id'] as int?,
      description: json['description'] as String,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      // 'id': instance.id,
      'child_id': instance.child_id,
      'description': instance.description,
      // 'created_at': instance.created_at,
    };
