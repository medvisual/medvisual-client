part of 'auth_manager_bloc.dart';

abstract class AuthManagerState {}

class AuthInProgress extends AuthManagerState {}

class Authenticated extends AuthManagerState {}

class AuthNone extends AuthManagerState {}

class Expired extends AuthManagerState {}
