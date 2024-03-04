import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static final CacheHelper _instance = CacheHelper._internal();
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  factory CacheHelper() {
    return _instance;
  }

  CacheHelper._internal();

  static Future<void> setValue(
      {required String key, required String value}) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<String> getValue({required String key,String nullHandler = ''}) async {
    return await secureStorage.read(
          key: key,
        ) ??
        nullHandler;
  }

  static Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}