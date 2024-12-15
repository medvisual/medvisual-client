// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmDisease extends _RealmDisease
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmDisease(
    int id,
    String name,
    String description,
    String department,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'department', department);
  }

  RealmDisease._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get department =>
      RealmObjectBase.get<String>(this, 'department') as String;
  @override
  set department(String value) =>
      RealmObjectBase.set(this, 'department', value);

  @override
  Stream<RealmObjectChanges<RealmDisease>> get changes =>
      RealmObjectBase.getChanges<RealmDisease>(this);

  @override
  Stream<RealmObjectChanges<RealmDisease>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RealmDisease>(this, keyPaths);

  @override
  RealmDisease freeze() => RealmObjectBase.freezeObject<RealmDisease>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'description': description.toEJson(),
      'department': department.toEJson(),
    };
  }

  static EJsonValue _toEJson(RealmDisease value) => value.toEJson();
  static RealmDisease _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'description': EJsonValue description,
        'department': EJsonValue department,
      } =>
        RealmDisease(
          fromEJson(id),
          fromEJson(name),
          fromEJson(description),
          fromEJson(department),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RealmDisease._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RealmDisease, 'RealmDisease', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('department', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
