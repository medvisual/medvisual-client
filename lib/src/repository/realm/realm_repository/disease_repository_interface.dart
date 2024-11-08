import 'package:medvisual/src/repository/realm/realm_models/realm_models.dart';

abstract interface class DiseaseRepositoryInterface {
  Future<List<RealmDisease>> getDiseases();
  Future<void> setDiseases(List<RealmDisease> diseases);
  Future<void> clear();
}
