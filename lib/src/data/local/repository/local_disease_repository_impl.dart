import 'package:medvisual/src/data/local/models/disease_realm.dart';
import 'package:medvisual/src/domain/local_repository/local_disease_repository.dart';
import 'package:realm/realm.dart';

class LocalDiseaseRepositoryImpl implements LocalDiseaseRepository {
  LocalDiseaseRepositoryImpl({required this.realm});

  final Realm realm;

  @override
  Future<void> clear() async {
    realm.deleteAll<RealmDisease>();
  }

  @override
  Future<List<RealmDisease>> getDiseases() async {
    return realm.all<RealmDisease>().toList();
  }

  @override
  Future<void> setDiseases(List<RealmDisease> diseases) async {
    realm.write(() {
      clear();
      realm.addAll(diseases, update: true);
    });
  }

  Future<List<RealmDisease>> findDiseases(String query) async {
    final allDiseases = realm.all<RealmDisease>().toList();
    final sortedDiseases = allDiseases
        .where((disease) =>
            disease.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return sortedDiseases;
  }

  @override
  Future<void> deleteDisease(int diseaseId) async {
    final diseaseToDelete = realm.all<RealmDisease>().firstWhere(
          (disease) => disease.id == diseaseId,
        );

    realm.write(() {
      realm.delete(diseaseToDelete);
    });
  }
}
