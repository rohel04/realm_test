import 'dart:io';

import 'package:realm/realm.dart';
import 'package:realm_mongo/model/custom_user.dart';
import 'package:realm_mongo/model/notes.dart';
import 'package:realm_mongo/model/todo.dart';

class RealmConfig {
  RealmConfig._();
  static final _instance = RealmConfig._();
  static RealmConfig get instance => _instance;

  late Realm realm;
  late App app;

  Future<void> init() async {
    try {
      final appConfig =
          AppConfiguration('application-0-twroi', httpClient: HttpClient());
      app = App(appConfig);
    } catch (e) {
      throw RealmException('Unable to initalize');
    }
  }

  // Future<User> authenticateAnonymously() async {
  //   try {
  //     var user = await app.logIn(Credentials.anonymous());
  //     final config = Configuration.flexibleSync(user, [TodoModel.schema]);
  //     realm = Realm(config);
  //     _runSubscription();
  //     return user;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<User> authenticateEmailPassword(String email, String password) async {
    try {
      var credentials = Credentials.emailPassword(email, password);
      var user = await app.logIn(credentials);
      await runConfig();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
      await authProvider.registerUser(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> runConfig() async {
    var user = app.currentUser!;
    final config =
        Configuration.flexibleSync(user, [TodoModel.schema, Notes.schema]);
    realm = await Realm.open(config);
    await _runSubscription();
  }

  Future<void> _runSubscription() async {
    try {
      var userId = RealmConfig.instance.app.currentUser!.id;
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(realm.query<TodoModel>("userId == '$userId'"));
        mutableSubscriptions.add(realm.all<Notes>());
      });
      await realm.subscriptions.waitForSynchronization();
    } catch (e) {
      throw RealmException('Unable to run subscription');
    }
  }

  void updateCurrentUserDetail(String name) async {
    try {
      final realm = RealmConfig.instance;
      final user = realm.app.currentUser!;
      final updatedTimestamp = DateTime.now().millisecondsSinceEpoch;
      final updatedCustomUserData = {
        "userId": user.id,
        "name": name,
        "lastUpdated": updatedTimestamp
      };

      await user.functions.call("onUserCreation", [updatedCustomUserData]);
      await user.refreshCustomData();
    } on RealmError catch (e) {
      throw RealmException(e.message ?? '');
    }
  }

  CustomeUser? getCurrentUserDetail() {
    Map<String, dynamic>? map =
        RealmConfig.instance.app.currentUser!.customData;
    return map == null ? null : CustomeUser.fromMap(map);
  }
}
