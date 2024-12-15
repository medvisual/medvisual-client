import 'package:medvisual/src/data/remote/models/disease/disease.dart';
import 'package:medvisual/src/data/remote/models/diseases_page/diseases_page.dart';

abstract interface class DiseaseRepository {
  Future<DiseasesPage> getDiseases(int page, String? department);
  Future<void> createDisease(Disease disease);
  Future<void> deleteDisease(int diseaseId);
}
