import 'package:shared_preferences/shared_preferences.dart';

class DataPreference{
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences? getPreference(){
    return sharedPreferences;
  }
}