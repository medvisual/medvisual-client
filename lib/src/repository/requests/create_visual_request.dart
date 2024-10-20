import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:medvisual/src/repository/models/visual_disease_model.dart';
import 'package:mime/mime.dart';

class VisualRequest {
  // Request for getting an AI opinion about image
  static Future<List<VisualDisease>> createVisualRequest(
      List<String> presumedDiseases, File image) async {
    await dotenv.load(fileName: ".env"); // loading file of enviroment
    try {
      String? mimeType = lookupMimeType(image.path);
      var formData = FormData.fromMap({
        'presumedDiseases': presumedDiseases.join(', '), // Backend will get
        'image': await MultipartFile.fromFile(
          image.path,
          contentType: MediaType.parse(mimeType!),
        )
      });

      final response = await Dio().post(
        // If no endpoint-api in .env throw exception about it
        dotenv.env['ENDPOINT-API'] ??
            (throw Exception(
                'No endpoint-api (https of backend) in your enviroment, please check and retry')),
        data: formData,
      );
      // Check for success request
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data as List<dynamic>;

        // TODO Delete and replace by json-serializeble
        List<VisualDisease> diseases = data.map((item) {
          return VisualDisease(
            name: item['disease'] as String,
            advice: item['advice'] as String,
            probability: (item['probability'] as num).toDouble(),
            verdict: item['verdict'] as String,
          );
        }).toList();
        return diseases;
      } else {
        throw Exception(
            'Status code is ${response.statusCode} and message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failure fetching data from endpoint, error: $e');
    }
  }
}
