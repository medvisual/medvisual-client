import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medvisual/src/repository/requests/auth_request.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TokenManager {
  final talker = GetIt.I<Talker>();
  final secureStorage = GetIt.I<FlutterSecureStorage>();

  Future<bool> tokenExist() async {
    return (await (secureStorage.containsKey(key: 'accessToken')) &&
        await (secureStorage.containsKey(key: 'refreshToken')));
  }

  bool expired(String token) {
    // FIXME: Delete log logic
    talker.log('Token created: ${JwtDecoder.getTokenTime(token)} ago');
    if (JwtDecoder.isExpired(token)) {
      talker.log('Token expired!');
      return true;
    } else {
      talker.log('Token isn\'t expired');
      return false;
    }
  }

  Future<String> getAccessToken() async {
    final secureStorage = GetIt.I<FlutterSecureStorage>();
    if (await secureStorage.containsKey(key: 'accessToken')) {
      return (await secureStorage.read(key: 'accessToken'))!;
    }
    throw Exception('Storage doesnt contain access token!');
  }

  Future<String> getRefreshToken() async {
    final secureStorage = GetIt.I<FlutterSecureStorage>();
    if (await secureStorage.containsKey(key: 'refreshToken')) {
      return (await secureStorage.read(key: 'refreshToken'))!;
    }
    throw Exception('Storage doesnt contain refresh token!');
  }

  Future<void> refreshTokensStorage(
      String accessToken, String refreshToken) async {
    talker.log('acessToken: $accessToken \n refreshToken: $refreshToken');
    await secureStorage.write(key: 'accessToken', value: accessToken);
    await secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<bool> isRefreshNeded() async {
    if (await tokenExist()) {
      if (expired(await getAccessToken())) {
        talker.log('Refresh needed!');
        return true;
      }
    }
    return false;
  }

  Future<void> refreshToken() async {
    final authRequest = AuthRequest(dio: GetIt.I<Dio>());

    try {
      final response = await authRequest.refreshAuth(await getRefreshToken());
      refreshTokensStorage(response.accessToken, response.refreshToken);
    } catch (e) {
      talker.error('Some problem while refreshing token: $e');
      throw Exception('Some problem while refreshing token: $e');
    }
  }
}
