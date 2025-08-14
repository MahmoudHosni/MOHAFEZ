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
    createBiikmarksTable( );

    return _database!;
  }

  Future<AppDatabase> init() async{
    return await $FloorAppDatabase.databaseBuilder('quran_data1.db').build() ;
  }

  Future<dynamic> createBiikmarksTable( ) async {
    var dbClient = await database;
    var count ;

    var exist = await dbClient.database.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='bookmarks';");
    print(("DB Table count ::   ${exist.toSet().length}"));
    if(exist.toSet().isEmpty) {
       await dbClient.database.execute("CREATE TABLE bookmarks ('ID'	INTEGER NOT NULL UNIQUE ,'aya_ID'	INTEGER NOT NULL,'name'	TEXT,'type' TEXT,PRIMARY KEY('ID' AUTOINCREMENT));");
       print("create table bookmarks >>   ");
    }

    return count;
  }
}
