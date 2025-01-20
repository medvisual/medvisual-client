part of 'auth_manager_bloc.dart';

abstract class AuthManagerEvent {}

class Login extends AuthManagerEvent {
  Login({required this.email, required this.password});

  final String email;
  final String password;
}

class Register extends AuthManagerEvent {
  Register(
      {required this.username, required this.email, required this.password});

  final String username;
  final String email;
  final String password;
}

class RefreshToken extends AuthManagerEvent {
  RefreshToken({required this.resfreshToken});

  final String resfreshToken;
}

class Logout extends AuthManagerEvent {}

class TokenExpired extends AuthManagerEvent {}

class TryInitUser extends AuthManagerEvent {}
