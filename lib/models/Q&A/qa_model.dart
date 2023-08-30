import 'package:json_annotation/json_annotation.dart';

part 'qa_model.g.dart';

@JsonSerializable()
class QaModel {
  final int? id;
  final String question;
  final String answer;

  QaModel({
    this.id,
    required this.question,
    required this.answer,
  });

  factory QaModel.fromJson(Map<String, dynamic> json) => _$QaModelFromJson(json);

  Map<String, dynamic> toJson() => _$QaModelToJson(this);

}
