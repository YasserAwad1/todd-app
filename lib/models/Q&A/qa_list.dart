import 'package:toddily_preschool/models/Q&A/qa_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qa_list.g.dart';

@JsonSerializable()
class QaList{
  List<QaModel> qa;

  QaList({
    required this.qa
  });

  factory QaList.fromJson(Map<String, dynamic> json) => _$QaListFromJson(json);

  Map<String, dynamic> toJson() => _$QaListToJson(this);

}