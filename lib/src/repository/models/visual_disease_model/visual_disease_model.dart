import 'package:json_annotation/json_annotation.dart';

part 'visual_disease_model.g.dart';

@JsonSerializable()
class VisualDisease {
  VisualDisease(
      {required this.name,
      required this.advice,
      required this.probability,
      required this.verdict});

  @JsonKey(name: 'disease')
  final String name;
  final String advice;
  final double probability;
  final String verdict;

  /// Connect the generated [_$VisualDiseaseFromJson] function to the `fromJson`
  /// factory.
  factory VisualDisease.fromJson(Map<String, dynamic> json) =>
      _$VisualDiseaseFromJson(json);

  /// Connect the generated [_$VisualDiseaseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VisualDiseaseToJson(this);
}
