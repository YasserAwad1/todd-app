// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QaModel _$QaModelFromJson(Map<String, dynamic> json) => QaModel(
      id: json['id'] as int?,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$QaModelToJson(QaModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
