import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medvisual/src/data/models/disease/disease.dart';
import 'package:medvisual/src/data/models/diseases_page/diseases_page.dart';
import 'package:medvisual/src/data/models/pagination/pagination.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:medvisual/src/data/models/page_meta/page_meta.dart';

class DiseaseRequest {
  DiseaseRequest({required this.dio});

  final Dio dio;
  final talker = GetIt.I<Talker>();
  Future<DiseasesPage> getDiseaseList(int page) async {
    try {
      final String endPoint = _getEndpoint('/api/diseases/get');
      final response = await dio.post(endPoint,
          data: Pagination(page: page, pageSize: 15).getPagination());
      return _handleResponse<DiseasesPage>(response, (response) {
        // Cast to Map<String, dynamic>
        response as Map<String, dynamic>;
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
      final response = await dio.post(endPoint, data: disease.toJson());

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
      final response = await dio.delete(endPoint);

      _handleResponse<void>(response, (_) {
        talker.log('Disease successfully deleted!');
      });
    } catch (e) {
      throw Exception('Exception occurred: $e');
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
