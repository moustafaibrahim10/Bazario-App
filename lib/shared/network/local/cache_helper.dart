import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    if (sharedPreferences != null) {
      return await sharedPreferences!.setBool(key, value);
    }
    return false;
  }

  static bool? getBoolean({
    required String key,
  }) {
    if (sharedPreferences != null) {
      return sharedPreferences!.getBool(key);
    }
    return null;
  }

  static Future<bool> saveData (
  {
    required String key,
    required dynamic value,
})async
  {
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is double) return await sharedPreferences!.setDouble(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);

      return false;
  }

  static dynamic getData(
  {
    required String key,
})
  {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData(
  {
    required String key,
}) async
  {
    return await sharedPreferences!.remove(key);
  }

}


