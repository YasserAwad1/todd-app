import 'package:json_annotation/json_annotation.dart';

part 'date_model.g.dart';

@JsonSerializable()
class DateModel {
  String date;

  DateModel({
    required this.date,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) => _$DateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateModelToJson(this);
}
