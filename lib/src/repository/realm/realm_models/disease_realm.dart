import 'package:realm/realm.dart';

part 'disease_realm.realm.dart';

@RealmModel()
class _RealmDisease {
  late int id;
  late String name;
  late String description;
  late String department;
}
