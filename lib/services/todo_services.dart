import 'package:realm/realm.dart';
import 'package:realm_mongo/model/todo.dart';
import 'package:realm_mongo/services/realm_config.dart';

class TodoServices {
  final Realm realm = RealmConfig.instance.realm;

  List<TodoModel> searchTodo(String text) {
    try {
      var todos = RealmConfig.instance.realm
          .query<TodoModel>(r"title CONTAINS[c] $0", [text]);
      return todos.toList();
    } on RealmError catch (e) {
      throw RealmException(e.message ?? 'Something went wrong');
    }
  }

  List<TodoModel> getTodos() {
    try {
      var todos = RealmConfig.instance.realm.all<TodoModel>();
      return todos.toList();
    } on RealmError catch (e) {
      throw RealmException(e.message ?? 'Something went wrong');
    }
  }

  void deleteTodo(TodoModel todo) {
    try {
      RealmConfig.instance.realm.write(() {
        RealmConfig.instance.realm.delete(todo);
      });
      RealmConfig.instance.realm.refresh();
    } on RealmError catch (e) {
      throw RealmException(e.message ?? 'Something went wrong');
    }
  }

  void addTodo(TodoModel todo) {
    try {
      RealmConfig.instance.realm.write(() {
        RealmConfig.instance.realm.add(todo);
      });
    } on RealmError catch (e) {
      throw RealmException(e.message ?? 'Something went wrong');
    }
  }

  void updateTodo(TodoModel todo, String title, String description) {
    try {
      RealmConfig.instance.realm.write(() {
        todo.title = title;
        todo.description = description;
      });
    } on RealmError catch (e) {
      throw RealmException(e.message ?? 'Something went wrong');
    }
  }
}
