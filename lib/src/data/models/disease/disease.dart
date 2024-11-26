import 'package:json_annotation/json_annotation.dart';
import 'package:medvisual/src/data/repository/realm/realm_models/disease_realm.dart';
import 'package:equatable/equatable.dart';

part 'disease.g.dart';

@JsonSerializable()
class Disease extends Equatable {
  const Disease(
      {this.id,
      required this.name,
      required this.description,
      required this.department});

  final int? id;
  final String name;
  final String description;
  final String department;

  RealmDisease toRealm() => RealmDisease(id!, name, description, department);
  static Disease fromRealm(RealmDisease realmDisease) => Disease(
      id: realmDisease.id,
      name: realmDisease.name,
      description: realmDisease.description,
      department: realmDisease.department);

  /// Connect the generated [_$DiseaseFromJson] function to the `fromJson`
  /// factory.
  factory Disease.fromJson(Map<String, dynamic> json) =>
      _$DiseaseFromJson(json);

  /// Connect the generated [_$DiseaseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DiseaseToJson(this);

  @override
  List<Object?> get props => [id, name, description, department];
}
