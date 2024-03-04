import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/helpers/cache_helper.dart';
import 'package:autiscope_app/core/resources/resources.dart';

abstract class SplashLocalDataSource {
  Future<void> setIsFirstTime();

  Future<bool> getIsFirstTime();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  @override
  Future<void> setIsFirstTime() async {
    try {
      if (bool.tryParse(await CacheHelper.getValue(
              key: CacheKeys.isFirstTime, nullHandler: 'true')) ??
          false) {
        await CacheHelper.setValue(key: CacheKeys.isFirstTime, value: 'false');
      }
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<bool> getIsFirstTime() async {
    try {
      return bool.tryParse(
              await CacheHelper.getValue(key: CacheKeys.isFirstTime)) ??
          true;
    } on Exception {
      throw CacheException();
    }
  }
}