import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medvisual/src/core/constants/app_constants.dart';
import 'package:medvisual/src/data/remote/models/disease/disease.dart';
import 'package:medvisual/src/data/remote/models/diseases_page/diseases_page.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:medvisual/src/data/remote/models/page_meta/page_meta.dart';

class DiseaseRequest {
  DiseaseRequest({required this.dio});

  final Dio dio;
  final talker = GetIt.I<Talker>();

  Future<DiseasesPage> getDiseaseList(int page, String? department) async {
    try {
      final String endPoint = _getEndpoint('/api/diseases');
      final response = await dio.get(endPoint, queryParameters: {
        'where[department]': department,
        'pagination[pageSize]': AppConstants.pageSizeConstant,
        'pagination[page]': page
      });
      return _handleResponse<DiseasesPage>(response, (response) {
        final meta = PageMeta.fromJson(response["meta"]);
        final diseasesList = (response["data"] as List<dynamic>).map((item) {
          return Disease.fromJson(item as Map<String, dynamic>);
        }).toList();

        // Return map with meta and diseases list
        return DiseasesPage(diseases: diseasesList, meta: meta);
      });
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<void> addDisease(Disease disease) async {
    try {
      final String endPoint = _getEndpoint('/api/diseases');
      final response = await dio.post(endPoint,
          data: disease.toJson(), options: Options(requestEncoder: null));
      _handleResponse<void>(response, (_) {
        talker.info('New disease successfully added!');
      });
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<void> deleteDisease(int diseaseId) async {
    try {
      final String endPoint = _getEndpoint('/api/diseases/$diseaseId');
      await dio.delete(endPoint);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 500:
          talker.info(
              'Server error code is 500, but it means that disease deleted');
          return;
        case 404:
          throw Exception('Disease not found');
        case 401:
          throw Exception('Unauthorized access');
        case 403:
          throw Exception('Forbidden access');
        default:
          throw Exception('Error occurred: ${e.message}');
      }
    } catch (e) {
      throw Exception(e);
    }
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
