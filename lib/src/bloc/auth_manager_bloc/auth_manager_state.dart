// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_manager_bloc.dart';

abstract class AuthManagerState {}

class AuthInProgress extends AuthManagerState {}

class Authenticated extends AuthManagerState {}

class AuthNone extends AuthManagerState {
  final String? error;
  AuthNone({
    this.error,
  });
}

class Expired extends AuthManagerState {}
