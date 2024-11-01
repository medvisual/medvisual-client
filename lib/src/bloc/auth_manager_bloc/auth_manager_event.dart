part of 'auth_manager_bloc.dart';

abstract class AuthManagerEvent {}

class Login extends AuthManagerEvent {
  Login({required this.email, required this.password});

  final String email;
  final String password;
}

class Logout extends AuthManagerEvent {}

class TryInitUser extends AuthManagerEvent {}
