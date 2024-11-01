import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medvisual/src/repository/models/diseases_list/disease.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DiseaseRequest {
  DiseaseRequest({required this.dio});

  final Dio dio;

  Future<List<Disease>> getDiseaseList() async {
    try {
      final String endPoint;
      if (dotenv.env['ENDPOINT-API'] != null) {
        endPoint = '${dotenv.env['ENDPOINT-API']!}/api/diseases';
      } else {
        throw Exception(
            'No endpoint-api (https of backend) in your enviroment, please check and retry');
      }
      final response = await dio.get(endPoint);
      // Check for success request
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data as List<dynamic>;
        List<Disease> diseasesList = data.map((item) {
          return Disease.fromJson(item as Map<String, dynamic>);
        }).toList();
        return diseasesList;
      } else {
        throw Exception(
            'Status code is ${response.statusCode} and message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Exeption was occured: $e');
    }
  }

  Future<void> addDisease(Disease disease) async {
    try {
      final String endPoint;
      await dotenv.load(fileName: ".env"); // loading file of enviroment
      if (dotenv.env['ENDPOINT-API'] != null) {
        endPoint = '${dotenv.env['ENDPOINT-API']!}/api/diseases';
      } else {
        throw Exception(
            'No endpoint-api (https of backend) in your .env file, please check and retry');
      }
      final data = disease.toJson();
      final response = await dio.post(endPoint, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        GetIt.I<Talker>().info('New disease successful added!');
      } else {
        throw Exception(
            'Status code is ${response.statusCode} and message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Exeption was occured: $e');
    }
  }
}
