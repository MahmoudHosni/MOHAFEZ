import 'ReadersDatabase.dart';

class ReadersFloorDB{
  static final ReadersFloorDB _db =  ReadersFloorDB._internal();
  ReadersFloorDB._internal();
  static ReadersFloorDB get instance => _db;
  static ReadersDatabase? _database=null;
  int readerID = 2;

  Future<ReadersDatabase>  database(int reader) async {
    if(_database != null)
      return _database!;

    readerID=reader;
    _database = await $FloorReadersDatabase.databaseBuilder('Ayat_${readerID}.db').build() ;
    return _database!;
  }

  Future<void> clear(int id) async {
    _database?.close();
    readerID=id;
    _database = await $FloorReadersDatabase.databaseBuilder('Ayat_${readerID}.db').build() ;
  }

  Future<ReadersDatabase> init() async{
    return await $FloorReadersDatabase.databaseBuilder('Ayat_${readerID}.db').build() ;
  }

  onGetReader(int? id) async {
    readerID=id!;
    _database = await $FloorReadersDatabase.databaseBuilder('Ayat_${readerID}.db').build() ;
  }
}