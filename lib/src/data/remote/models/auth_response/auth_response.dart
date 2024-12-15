import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends Equatable {
  const AuthResponse({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  /// Connect the generated [_$DiseaseFromJson] function to the `fromJson`
  /// factory.
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  /// Connect the generated [_$DiseaseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
