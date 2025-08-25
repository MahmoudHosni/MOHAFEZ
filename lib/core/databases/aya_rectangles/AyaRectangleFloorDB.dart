import 'package:mohafez/utils/Constants.dart';

import 'AyaRectanglesDB.dart';

class AyaRectangleFloorDB{
  static final AyaRectangleFloorDB _db = new AyaRectangleFloorDB._internal();
  AyaRectangleFloorDB._internal();
  static AyaRectangleFloorDB get instance => _db;
  static AyaRectanglesDB? _database=null;

  Future<AyaRectanglesDB> get database async {
    if(_database != null)
      return _database!;
    _database = await $FloorAyaRectanglesDB.databaseBuilder(Constants.RectanglesDB).build() ;
    return _database!;
  }

  Future<AyaRectanglesDB> init() async{
    return await $FloorAyaRectanglesDB.databaseBuilder(Constants.RectanglesDB).build() ;
  }
}