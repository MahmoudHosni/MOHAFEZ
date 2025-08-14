import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/Constants.dart';

class ReadersPrefsDataSource {
  final Future<SharedPreferences> sharedPreferences ;

  ReadersPrefsDataSource({ required this.sharedPreferences });

  Future<int?> getSelectedReader()  {
    return  sharedPreferences.then((value) => value.getInt(Constants.SelectedReaderKey)??1);
  }

  Future<bool> saveSelectedReader(int readerId) async {
    return await sharedPreferences.then((value) => value.setInt(Constants.SelectedReaderKey, readerId));
  }
}