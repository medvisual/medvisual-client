import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/data/models/user/user.dart';
import 'package:medvisual/src/data/repository/requests/auth_request.dart';
import 'package:medvisual/src/data/repository/managers/token_manager/token_manager.dart';

part 'auth_manager_event.dart';
part 'auth_manager_state.dart';

class AuthManagerBloc extends Bloc<AuthManagerEvent, AuthManagerState> {
  final secureStorage = GetIt.I<FlutterSecureStorage>();
  final authRequest = AuthRequest(dio: GetIt.I<Dio>());
  final tokenManager = TokenManager();

  AuthManagerBloc() : super(AuthNone()) {
    on<TryInitUser>((event, emit) async {
      try {
        if (await secureStorage.containsKey(key: 'accessToken')) {
          emit(Authenticated());
        } else {
          emit(AuthNone());
        }
      } catch (e) {
        throw Exception('Error was occured in InitUser. Error : $e');
      }
    });

    on<Login>((event, emit) async {
      try {
        emit(AuthInProgress());
        final user = User(email: event.email, password: event.password);
        final response = await authRequest.signIn(user);
        tokenManager.refreshTokensStorage(
            response.accessToken, response.refreshToken);
        emit(Authenticated());
      } catch (e) {
        emit(AuthNone());
        throw Exception('Error was occured in AuthManagerBloc. Error: $e');
      }
    });

    on<Logout>((event, emit) async {
      emit(AuthNone());
    });

    on<TokenExpired>((event, emit) async {
      emit(Expired());
    });
  }
}
