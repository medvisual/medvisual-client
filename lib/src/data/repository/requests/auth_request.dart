import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medvisual/src/data/models/auth_response/auth_response.dart';
import 'package:medvisual/src/data/models/user/user.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';

class AuthRequest {
  final Dio dio;
  final talker = GetIt.I<Talker>();

  AuthRequest({required this.dio});

  Future<AuthResponse> signIn(User user) async {
    try {
      final String endPoint = _getEndpoint('/api/auth/signin');
      final response = await dio.post(
        endPoint,
        data: user.toJson(),
      );

      return _handleResponse<AuthResponse>(response, (data) {
        return AuthResponse.fromJson(data as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<AuthResponse> refreshAuth(String refreshToken) async {
    try {
      final String endPoint = _getEndpoint('/api/auth/refresh');
      final response = await dio.post(
        endPoint,
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      return _handleResponse<AuthResponse>(response, (data) {
        return AuthResponse.fromJson(data as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  String _getEndpoint(String path) {
    final String? baseUrl = dotenv.env['ENDPOINT-API'];
    if (baseUrl != null) {
      return '$baseUrl$path';
    } else {
      throw Exception(
          'No endpoint-api (https of backend) in your environment, please check and retry');
    }
  }

  T _handleResponse<T>(Response response, T Function(dynamic data) onSuccess) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return onSuccess(response.data);
    } else if (response.statusCode == 401) {
      talker.log('Refresh token expired, please sign in again');
      throw Exception('Refresh token expired, please sign in again');
    } else {
      throw Exception(
          'Status code is ${response.statusCode} and message: ${response.statusMessage}');
    }
  }
}
