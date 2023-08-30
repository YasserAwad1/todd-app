// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qa_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QaList _$QaListFromJson(Map<String, dynamic> json) => QaList(
      qa: (json['qa'] as List<dynamic>)
          .map((e) => QaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QaListToJson(QaList instance) => <String, dynamic>{
      'qa': instance.qa,
    };
