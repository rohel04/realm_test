import 'package:realm/realm.dart';
import 'package:realm_mongo/model/notes.dart';
import 'package:realm_mongo/model/todo.dart';
import 'package:realm_mongo/services/realm_config.dart';

class NotesServices {
  final Realm realm = RealmConfig.instance.realm;

  void addNotesToTodo(TodoModel todo, Notes note) {
    try {
      RealmConfig.instance.realm.write(() {
        todo.notes.add(note);
      });
    } on RealmError catch (e) {
      throw RealmException(e.message ?? 'Something went wrong');
    }
  }
}
