// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class TodoModel extends _TodoModel
    with RealmEntity, RealmObjectBase, RealmObject {
  TodoModel(
    ObjectId id,
    String title,
    String description,
    String userId, {
    Iterable<Notes> notes = const [],
    Map<String, RealmValue> metaData = const {},
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set<RealmList<Notes>>(
        this, 'notes', RealmList<Notes>(notes));
    RealmObjectBase.set<RealmMap<RealmValue>>(
        this, 'metaData', RealmMap<RealmValue>(metaData));
  }

  TodoModel._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  RealmList<Notes> get notes =>
      RealmObjectBase.get<Notes>(this, 'notes') as RealmList<Notes>;
  @override
  set notes(covariant RealmList<Notes> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmMap<RealmValue> get metaData =>
      RealmObjectBase.get<RealmValue>(this, 'metaData') as RealmMap<RealmValue>;
  @override
  set metaData(covariant RealmMap<RealmValue> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TodoModel>> get changes =>
      RealmObjectBase.getChanges<TodoModel>(this);

  @override
  TodoModel freeze() => RealmObjectBase.freezeObject<TodoModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TodoModel._);
    return const SchemaObject(ObjectType.realmObject, TodoModel, 'TodoModel', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('notes', RealmPropertyType.object,
          linkTarget: 'Notes', collectionType: RealmCollectionType.list),
      SchemaProperty('metaData', RealmPropertyType.mixed,
          optional: true, collectionType: RealmCollectionType.map),
    ]);
  }
}
