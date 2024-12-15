import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medvisual/src/data/remote/models/visual_disease_model/visual_disease_model.dart';
import 'package:medvisual/src/data/remote/request/visual_request.dart';
import 'package:medvisual/src/domain/remote_repository/visual_repository.dart';

class CreateVisualRepositoryImpl implements VisualRepository {
  CreateVisualRepositoryImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<VisualDisease>> makeVerdict(
      File image, List<String> presumedDiseases) async {
    final createVisualRequest = VisualRequest(dio: dio);
    final visualDiseaseList =
        await createVisualRequest.makeAiVerdict(presumedDiseases, image);
    return visualDiseaseList;
  }
}
