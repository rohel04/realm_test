// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Notes extends $Notes with RealmEntity, RealmObjectBase, RealmObject {
  Notes(
    ObjectId id,
    String text,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'text', text);
  }

  Notes._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get text => RealmObjectBase.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObjectBase.set(this, 'text', value);

  @override
  Stream<RealmObjectChanges<Notes>> get changes =>
      RealmObjectBase.getChanges<Notes>(this);

  @override
  Notes freeze() => RealmObjectBase.freezeObject<Notes>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Notes._);
    return const SchemaObject(ObjectType.realmObject, Notes, 'Notes', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('text', RealmPropertyType.string),
    ]);
  }
}
