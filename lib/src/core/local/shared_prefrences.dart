import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static  late var sharedPreferences ;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future <bool?> saveData({required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences?.setInt(key, value);
    } else if (value is String) {
      return  await sharedPreferences?.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences?.setBool(key, value);
    }
    return await sharedPreferences?.setDouble(key, value);
  }

  static Future <dynamic> getData({required  String key}) async
  {
    return sharedPreferences.get(key);
  }

  static  void removeData({required String key}) {
    sharedPreferences?.remove(key);
  }


}
