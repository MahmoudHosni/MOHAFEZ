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
    _database = await $FloorAppDatabase.databaseBuilder('quran_data1.db').build() ;
    return _database!;
  }

  Future<AppDatabase> init() async{
    return await $FloorAppDatabase.databaseBuilder('quran_data1.db').build() ;
  }

}
