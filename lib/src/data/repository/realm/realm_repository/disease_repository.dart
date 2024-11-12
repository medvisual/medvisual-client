import 'package:medvisual/src/data/repository/realm/realm_models/disease_realm.dart';
import 'package:medvisual/src/data/repository/realm/realm_repository/disease_repository_interface.dart';
import 'package:realm/realm.dart';

class DiseaseRepository implements DiseaseRepositoryInterface {
  DiseaseRepository({required this.realm});

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
}
