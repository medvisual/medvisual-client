import 'package:medvisual/src/data/local/models/disease_realm.dart';

abstract interface class LocalDiseaseRepository {
  Future<List<RealmDisease>> getDiseases();
  Future<void> setDiseases(List<RealmDisease> diseases);
  Future<void> deleteDisease(int diseaseId);
  Future<void> clear();
}
