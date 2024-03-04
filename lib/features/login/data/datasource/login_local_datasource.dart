import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/helpers/cache_helper.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginLocalDataSource {
  Future<void> setUserInfo({required User user});

  Future<String> getUserInfo();

  Future<void> setIsLogin();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  @override
  Future<void> setUserInfo({required User user}) async {
    try {
      await CacheHelper.setValue(key: CacheKeys.userInfo, value: user.uid);
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<String> getUserInfo() async {
    try {
      return await CacheHelper.getValue(
        key: CacheKeys.userInfo,
      );
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> setIsLogin() async {
    try {
      await CacheHelper.setValue(key: CacheKeys.isLogin, value: 'true');
    } on Exception {
      throw CacheException();
    }
  }
}
