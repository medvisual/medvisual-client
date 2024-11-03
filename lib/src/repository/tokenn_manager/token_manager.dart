import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';

class TokenManager {
  Future<String> getToken() async {
    final secureStorage = GetIt.I<FlutterSecureStorage>();
    if (await secureStorage.containsKey(key: 'accessToken')) {
      return (await secureStorage.read(key: 'accessToken'))!;
    }
    throw Exception('Non auth user!');
  }

  Future<void> refreshToken() async {
    final secureStorage = GetIt.I<FlutterSecureStorage>();
    GetIt.I<AuthManagerBloc>().add(RefreshToken(
        resfreshToken: (await secureStorage.read(key: 'refreshToken'))!));
  }
}
