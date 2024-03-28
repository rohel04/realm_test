import 'package:realm/realm.dart';
part 'notes.g.dart';

@RealmModel()
class $Notes {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String text;
}
