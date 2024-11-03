import 'package:json_annotation/json_annotation.dart';
import 'package:medvisual/src/repository/enums/user_roles_enum.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
      {required this.email, required this.password, this.role = UserRole.user});

  final String email;
  final String password;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final UserRole role;

  bool get isAdmin => role == UserRole.admin ? true : false;
  bool get isDoctor => role == UserRole.doctor ? true : false;
  bool get isUser => role == UserRole.user ? true : false;

  /// Connect the generated [_$UserFromJson] function to the `fromJson`
  /// factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
