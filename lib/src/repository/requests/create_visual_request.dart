import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';
import 'package:medvisual/src/bloc/auth_manager_bloc/auth_manager_bloc.dart';
import 'package:medvisual/src/repository/models/visual_disease_model/visual_disease_model.dart';
import 'package:mime/mime.dart';

class VisualRequest {
  VisualRequest({required this.dio});

  final Dio dio;

  // Request for getting an AI opinion about image
  Future<List<VisualDisease>> createVisualRequest(
      List<String> presumedDiseases, File image) async {
    try {
      String? mimeType = lookupMimeType(image.path);
      var formData = FormData.fromMap({
        'presumedDiseases[]': presumedDiseases.join(', '), // Backend will get
        'image': await MultipartFile.fromFile(
          image.path,
          contentType: MediaType.parse(mimeType!),
        )
      });
      final String endPoint;
      if (dotenv.env['ENDPOINT-API'] != null) {
        endPoint = '${dotenv.env['ENDPOINT-API']!}/api/visual/create';
      } else {
        throw Exception(
            'No endpoint-api (https of backend) in your enviroment, please check and retry');
      }
      final jwtToken = await getToken();
      final response = await dio.post(
          // If no endpoint-api in .env throw exception about it
          endPoint,
          data: formData,
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}));
      // Check for success request
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data as List<dynamic>;

        List<VisualDisease> diseases = data.map((item) {
          return VisualDisease.fromJson(item as Map<String, dynamic>);
        }).toList();
        return diseases;
      } else {
        throw Exception(
            'Status code is ${response.statusCode} and message: ${response.statusMessage}');
      }
    } catch (e) {
      refreshToken();
      throw Exception('Failure fetching data from endpoint, error: $e');
    }
  }

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
