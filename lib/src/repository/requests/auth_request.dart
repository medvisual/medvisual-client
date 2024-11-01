import 'dart:async';
import 'package:dio/dio.dart';
import 'package:medvisual/src/repository/models/auth_response/auth_response.dart';
import 'package:medvisual/src/repository/models/user/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRequest {
  AuthRequest({required this.dio});
  final Dio dio;
  Future<AuthResponse> signin(User user) async {
    try {
      final String endPoint;
      if (dotenv.env['ENDPOINT-API'] != null) {
        endPoint = '${dotenv.env['ENDPOINT-API']!}/api/auth/signin';
      } else {
        throw Exception(
            'No endpoint-api (https of backend) in your enviroment, please check and retry');
      }
      final response = await dio.post(
        // If no endpoint-api in .env throw exception about it
        endPoint,
        data: user.toJson(),
      );
      // Check for success request
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        final AuthResponse authResponse = AuthResponse.fromJson(data);
        return authResponse;
      } else {
        throw Exception(
            'Status code is ${response.statusCode} and message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }
}
