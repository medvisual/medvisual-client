import 'package:medvisual/src/repository/realm/realm_models/disease_realm.dart';
import 'package:medvisual/src/repository/realm/realm_repository/disease_repository_interface.dart';
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
}
