import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  AuthResponse({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  /// Connect the generated [_$DiseaseFromJson] function to the `fromJson`
  /// factory.
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  /// Connect the generated [_$DiseaseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
