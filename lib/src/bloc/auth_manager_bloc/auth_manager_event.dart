part of 'auth_manager_bloc.dart';

abstract class AuthManagerEvent {}

class Login extends AuthManagerEvent {
  Login({required this.email, required this.password});

  final String email;
  final String password;
}

class RefreshToken extends AuthManagerEvent {
  //FIXME: No need in new logic
  RefreshToken({required this.resfreshToken});

  final String resfreshToken;
}

class Logout extends AuthManagerEvent {}

class TokenExpired extends AuthManagerEvent {}

class TryInitUser extends AuthManagerEvent {}
