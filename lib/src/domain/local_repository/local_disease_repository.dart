import 'package:medvisual/src/data/local/models/disease_realm.dart';

abstract interface class LocalDiseaseRepository {
  Future<List<RealmDisease>> getDiseases(String? department);
  Future<void> setDiseases(List<RealmDisease> diseases);
  Future<void> deleteAllDiseases();
  Future<void> deleteDisease(int diseaseId);
  Future<void> clear();
}
