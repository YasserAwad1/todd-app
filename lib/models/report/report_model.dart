import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  final int? id;
  final int? child_id;
  final String description;
  final String? created_at;

  ReportModel({
    this.id,
    this.child_id,
    required this.description,
    this.created_at,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
