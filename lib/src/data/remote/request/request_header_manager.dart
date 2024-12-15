import 'package:dio/dio.dart';
import 'package:medvisual/src/domain/managers/token_manager/token_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';

class UpdateTokenInterceptor extends Interceptor {
  final TokenManager tokenManager;

  UpdateTokenInterceptor({required this.tokenManager});

  //FIXME: If it first sign in without token, it will be error and infinite loop
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authManager = GetIt.I<AuthManagerBloc>();
    if (authManager.state is AuthNone || authManager.state is AuthInProgress) {
      handler.next(options);
      return;
    }
    final token = await tokenManager.getAccessToken();
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
