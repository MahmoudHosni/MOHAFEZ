import '../../../utils/Constants.dart';
import 'AppDatabase.dart';

class QuranFloorDB{
  static final QuranFloorDB _db = new QuranFloorDB._internal();
  QuranFloorDB._internal();
  static QuranFloorDB get instance => _db;
  static AppDatabase? _database=null;

  Future<AppDatabase> get database async {
    if(_database != null) {
      return _database!;
    }
    _database = await $FloorAppDatabase.databaseBuilder(Constants.QuranDB).build() ;
    return _database!;
  }

  Future<AppDatabase> init() async{
    return await $FloorAppDatabase.databaseBuilder(Constants.QuranDB).build() ;
  }

}
