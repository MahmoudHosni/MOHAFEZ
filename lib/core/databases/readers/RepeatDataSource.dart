import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/Constants.dart';

class RepeatDataSource {
  final Future<SharedPreferences> sharedPreferences ;

  RepeatDataSource({ required this.sharedPreferences });

  Future<int?> getRepeatedAyaCount() async {
    return await sharedPreferences.then((value) => value.getInt(Constants.RepeatedAyaKey)??1);
  }

  Future<bool> saveRepeatedAyaCount(int rpAya) async {
    return await sharedPreferences.then((value) => value.setInt(Constants.RepeatedAyaKey, rpAya));
  }

  Future<int?> getRepeatedRangeCount() async {
    return await sharedPreferences.then((value) => value.getInt(Constants.RepeatedRangeKey)??1);
  }

  Future<bool> saveRepeatedRangeCount(int rpRange) async {
    return await sharedPreferences.then((value) => value.setInt(Constants.RepeatedRangeKey, rpRange));
  }
}