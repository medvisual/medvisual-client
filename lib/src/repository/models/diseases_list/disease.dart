import 'package:json_annotation/json_annotation.dart';

part 'disease.g.dart';

@JsonSerializable()
class Disease {
  const Disease(
      {this.id,
      required this.name,
      required this.description,
      required this.department});

  final int? id;
  final String name;
  final String description;
  final String department;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Disease.fromJson(Map<String, dynamic> json) =>
      _$DiseaseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DiseaseToJson(this);
}
