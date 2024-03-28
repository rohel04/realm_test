import 'package:realm/realm.dart';
import 'package:realm_mongo/model/notes.dart';
part 'todo.g.dart';

@RealmModel()
class _TodoModel {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String title;
  late String description;
  late String userId;
  late List<$Notes> notes;
  late Map<String, RealmValue> metaData;
}
