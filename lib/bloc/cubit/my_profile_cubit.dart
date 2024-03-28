import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/model/custom_user.dart';
import 'package:realm_mongo/services/realm_config.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(MyProfileInitial());

  RealmConfig realm = RealmConfig.instance;

  getMyProfileDetail() async {
    var user = realm.getCurrentUserDetail();
    emit(MyProfileLoaded(user: user ?? CustomeUser(userId: '-1', name: '')));
  }

  upateProfile(String name) async {
    try {
      realm.updateCurrentUserDetail(name);
      getMyProfileDetail();
    } on RealmException catch (e) {
      log(e.message);
    }
  }
}
