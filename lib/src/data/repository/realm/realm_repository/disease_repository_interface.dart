import 'package:medvisual/src/data/repository/realm/realm_models/disease_realm.dart';

abstract interface class DiseaseRepositoryInterface {
  Future<List<RealmDisease>> getDiseases();
  Future<void> setDiseases(List<RealmDisease> diseases);
  Future<void> clear();
}
