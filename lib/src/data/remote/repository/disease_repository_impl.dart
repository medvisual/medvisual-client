import 'package:dio/dio.dart';
import 'package:medvisual/src/data/remote/models/disease/disease.dart';
import 'package:medvisual/src/data/remote/models/diseases_page/diseases_page.dart';
import 'package:medvisual/src/data/remote/request/disease_request.dart';
import 'package:medvisual/src/domain/remote_repository/disease_repository.dart';

class DiseaseRepositoryImpl implements DiseaseRepository {
  DiseaseRepositoryImpl({required this.dio});

  final Dio dio;

  @override
  Future<void> createDisease(Disease disease) async {
    final diseaseRequest = DiseaseRequest(dio: dio);
    await diseaseRequest.addDisease(disease);
  }

  @override
  Future<void> deleteDisease(int diseaseId) async {
    final diseaseRequest = DiseaseRequest(dio: dio);
    await diseaseRequest.deleteDisease(diseaseId);
  }

  @override
  Future<DiseasesPage> getDiseases(int page) async {
    final diseaseRequest = DiseaseRequest(dio: dio);
    final diseasePage = await diseaseRequest.getDiseaseList(page);
    return diseasePage;
  }
}
