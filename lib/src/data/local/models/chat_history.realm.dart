// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ChatMessage extends _ChatMessage
    with RealmEntity, RealmObjectBase, RealmObject {
  ChatMessage(
    String role,
    String text,
  ) {
    RealmObjectBase.set(this, 'role', role);
    RealmObjectBase.set(this, 'text', text);
  }

  ChatMessage._();

  @override
  String get role => RealmObjectBase.get<String>(this, 'role') as String;
  @override
  set role(String value) => RealmObjectBase.set(this, 'role', value);

  @override
  String get text => RealmObjectBase.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObjectBase.set(this, 'text', value);

  @override
  Stream<RealmObjectChanges<ChatMessage>> get changes =>
      RealmObjectBase.getChanges<ChatMessage>(this);

  @override
  Stream<RealmObjectChanges<ChatMessage>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ChatMessage>(this, keyPaths);

  @override
  ChatMessage freeze() => RealmObjectBase.freezeObject<ChatMessage>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'role': role.toEJson(),
      'text': text.toEJson(),
    };
  }

  static EJsonValue _toEJson(ChatMessage value) => value.toEJson();
  static ChatMessage _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'role': EJsonValue role,
        'text': EJsonValue text,
      } =>
        ChatMessage(
          fromEJson(role),
          fromEJson(text),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ChatMessage._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ChatMessage, 'ChatMessage', [
      SchemaProperty('role', RealmPropertyType.string),
      SchemaProperty('text', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class ChatHistory extends _ChatHistory
    with RealmEntity, RealmObjectBase, RealmObject {
  ChatHistory(
    String id,
    String name, {
    Iterable<ChatMessage> messages = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<ChatMessage>>(
        this, 'messages', RealmList<ChatMessage>(messages));
  }

  ChatHistory._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<ChatMessage> get messages =>
      RealmObjectBase.get<ChatMessage>(this, 'messages')
          as RealmList<ChatMessage>;
  @override
  set messages(covariant RealmList<ChatMessage> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ChatHistory>> get changes =>
      RealmObjectBase.getChanges<ChatHistory>(this);

  @override
  Stream<RealmObjectChanges<ChatHistory>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ChatHistory>(this, keyPaths);

  @override
  ChatHistory freeze() => RealmObjectBase.freezeObject<ChatHistory>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'messages': messages.toEJson(),
    };
  }

  static EJsonValue _toEJson(ChatHistory value) => value.toEJson();
  static ChatHistory _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        ChatHistory(
          fromEJson(id),
          fromEJson(name),
          messages: fromEJson(ejson['messages']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ChatHistory._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, ChatHistory, 'ChatHistory', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('messages', RealmPropertyType.object,
          linkTarget: 'ChatMessage', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
