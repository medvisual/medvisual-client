import 'package:dio/dio.dart';
import 'package:medvisual/src/data/repository/managers/token_manager/token_manager.dart';

class UpdateTokenInterceptor extends Interceptor {
  final TokenManager tokenManager;

  UpdateTokenInterceptor({required this.tokenManager});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenManager.getAccessToken();
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
