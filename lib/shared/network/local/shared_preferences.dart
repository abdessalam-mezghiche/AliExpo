import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(
      {required String key, required dynamic value}) async {
    bool? boolReturn;
    if (value is bool) {
      boolReturn = await sharedPreferences?.setBool(key, value);
    }
    if (value is int) boolReturn = await sharedPreferences?.setInt(key, value);
    if (value is String) {
      boolReturn = await sharedPreferences?.setString(key, value);
    }
    if (value is double) {
      boolReturn = await sharedPreferences?.setDouble(key, value);
    }

    return boolReturn;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);
  }

  static Future<bool?> removeData({required String key}) async {
    return await sharedPreferences?.remove(key);
  }
}
