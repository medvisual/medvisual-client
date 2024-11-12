import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:medvisual/src/data/models/visual_disease_model/visual_disease_model.dart';
import 'package:mime/mime.dart';

class VisualRequest {
  VisualRequest({required this.dio});

  final Dio dio;

  Future<List<VisualDisease>> createVisualRequest(
      List<String> presumedDiseases, File image) async {
    try {
      final formData = await _prepareFormData(presumedDiseases, image);
      final String endPoint = _getEndpoint('/api/visual/create');

      final response = await dio.post(endPoint, data: formData);

      return _handleResponse<List<VisualDisease>>(response, (data) {
        return (data as List<dynamic>).map((item) {
          return VisualDisease.fromJson(item as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      throw Exception('Failure fetching data from endpoint, error: $e');
    }
  }

  Future<FormData> _prepareFormData(
      List<String> presumedDiseases, File image) async {
    String? mimeType = lookupMimeType(image.path);
    return FormData.fromMap({
      'presumedDiseases[]': presumedDiseases,
      'image': await MultipartFile.fromFile(
        image.path,
        contentType: MediaType.parse(mimeType!),
      )
    });
  }

  String _getEndpoint(String path) {
    final String? baseUrl = dotenv.env['ENDPOINT-API'];
    if (baseUrl != null) {
      return '$baseUrl$path';
    } else {
      throw Exception(
          'No endpoint-api in your environment, please check and retry');
    }
  }

  T _handleResponse<T>(Response response, T Function(dynamic data) onSuccess) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return onSuccess(response.data);
    } else {
      throw Exception(
          'Status code is ${response.statusCode} and message: ${response.statusMessage}');
    }
  }
}
