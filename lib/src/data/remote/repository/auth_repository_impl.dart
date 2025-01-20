import 'package:dio/dio.dart';
import 'package:medvisual/src/data/remote/models/auth_response/auth_response.dart';
import 'package:medvisual/src/data/remote/models/user/user.dart';
import 'package:medvisual/src/data/remote/request/auth_request.dart';
import 'package:medvisual/src/domain/remote_repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.dio);
  final Dio dio;

  @override
  Future<AuthResponse> login(User user) async {
    final authRequest = AuthRequest(dio: dio);
    final authReposnse = await authRequest.signIn(user);
    return authReposnse;
  }

  @override
  Future<void> register(User user) async {
    final authRequest = AuthRequest(dio: dio);
    await authRequest.signUp(user);
  }
}
