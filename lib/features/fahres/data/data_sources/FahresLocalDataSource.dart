import '../../../../core/databases/quran/AppDatabase.dart';
import '../../../../core/databases/quran/QuranFloorDB.dart';
import '../../../../core/entity/quran/Juza.dart';
import '../../../../core/entity/quran/Quarter.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/entity/quran/Sora.dart';

abstract class FahresDataSource {
  Future<List<Sora>> getAllSoras();
  Future<List<Juza>> getAllAjza();
  Future<List<MQuarter>> getAllAjzaWithQuarters();
  Future<Sora?>       getSoraByID(int id);
  Future<Juza?>       getJuzaByID(int id);
  Future<List<Sora>>  searchInSoras(String word);
  Future<List<Juza>>  searchInAjza(String word);
  Future<Quran?>      getFirstAyaInSora(int soraNum);
  Future<List<Quran?>>      getFirstAyaInPage(int page);
}

class FahresLocalDataSource extends FahresDataSource{
  @override
  Future<List<Juza>> getAllAjza() {
    return QuranFloorDB.instance.database.then((value) => value.juzaDao.getAllAjza());
  }

  @override
  Future<List<Sora>> getAllSoras() {
    return QuranFloorDB.instance.database.then((value) => value.soraDao.getAllSoras());
  }

  @override
  Future<Juza?> getJuzaByID(int id) {
    var result=  (QuranFloorDB.instance.database.then((value) => value.juzaDao.getJuzaByID(id)));
    return result;
  }

  @override
  Future<Sora?> getSoraByID(int id) {
    var result=  (QuranFloorDB.instance.database.then((value) => value.soraDao.getSoraByID(id)));
    return result;
  }

  @override
  Future<List<Juza>> searchInAjza(String word) {
    return QuranFloorDB.instance.database.then((value) => value.juzaDao.searchInAjza("%"+word+"%"));
  }

  @override
  Future<List<Sora>> searchInSoras(String word) {
    return QuranFloorDB.instance.database.then((value) => value.soraDao.searchInSoras("%"+word+"%"));
  }

  @override
  Future<List<MQuarter>> getAllAjzaWithQuarters() async{
    var db=await QuranFloorDB.instance.database;
    var quarters =await  db.quarterDao.GetAllQuarters();

    List<MQuarter> res = [];
    for (int i=0;i< quarters.length;i++) {
      var temp = quarters[i];
      var ayat =await db.ayaDao.getAyatByID(quarters[i].AyaId-1, quarters[i].AyaId);
      var tempAya = quarters[i].AyaId>1? ayat[1] : ayat[0];

      temp.aya = tempAya;
      if (res.isNotEmpty) {
        var prevQuarter = res[res.length - 1];
        prevQuarter.endPageNo=(ayat[0]?.PageNum??0);
        res[res.length - 1] = prevQuarter;
      }
      res.add(temp);
    }

    if (res.isNotEmpty) {
      var lastQuarter = res[res.length - 1];
      lastQuarter.endPageNo=604;
      res[res.length - 1] = lastQuarter;
    }
    var data = Future.value(quarters);
    return data;
  }

  getAyaByID(AppDatabase db,int ayaId) {
    return db.ayaDao.getAyaByID(ayaId);
  }

  @override
  Future<Quran?> getFirstAyaInSora(int soraNum) {
    return QuranFloorDB.instance.database.then((value) => value.ayaDao.getAyaOf(1,soraNum));
  }

  @override
  Future<List<Quran?>> getFirstAyaInPage(int page) {
    return QuranFloorDB.instance.database.then((value) => value.ayaDao.getAyatInPage(page));
  }


}