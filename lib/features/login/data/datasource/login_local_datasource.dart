import 'dart:convert';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/helpers/cache_helper.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginLocalDataSource {
  Future<void> setUserInfo({required User user});

  Future<User> getUserInfo();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  @override
  Future<void> setUserInfo({required User user}) async {
    try {
      await CacheHelper.setValue(
          key: CacheKeys.userInfo, value: json.encode(user));
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<User> getUserInfo() async {
    try {
      return json.decode(await CacheHelper.getValue(
        key: CacheKeys.userInfo,
      ));
    } on Exception {
      throw CacheException();
    }
  }
}
