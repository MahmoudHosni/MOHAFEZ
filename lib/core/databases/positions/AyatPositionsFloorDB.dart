import 'AyatPositionDB.dart';

class AyatPositionsFloorDB{
  static final AyatPositionsFloorDB _db = new AyatPositionsFloorDB._internal();
  AyatPositionsFloorDB._internal();
  static AyatPositionsFloorDB get instance => _db;
  static AyatPositionDB? _database=null;

  Future<AyatPositionDB> get database async {
    if(_database != null)
      return _database!;
    _database = await $FloorAyatPositionDB.databaseBuilder('Ayatpositions1New.db').build() ;
    return _database!;
  }

  Future<AyatPositionDB> init() async{
    return await $FloorAyatPositionDB.databaseBuilder('Ayatpositions1New.db').build() ;
  }
}