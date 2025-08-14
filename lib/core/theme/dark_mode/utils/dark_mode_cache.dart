import 'package:shared_preferences/shared_preferences.dart';
class DarkModeCache{
  final SharedPreferences sharedPreferences;
  DarkModeCache({required this.sharedPreferences});

  Future<bool>putBoolean ({
    required String key,
    required bool value
  })async{
    return await sharedPreferences.setBool(key, value);
  }
  bool? getBoolean({required String key}){
    return  sharedPreferences.getBool(key);
  }
}