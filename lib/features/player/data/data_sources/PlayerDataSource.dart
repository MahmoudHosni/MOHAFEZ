import 'dart:collection';
import '../../../../core/databases/quran/QuranFloorDB.dart';
import '../../../../core/databases/readers/ReadersFloorDB.dart';
import '../../../../core/databases/readers/RepeatDataSource.dart';
import '../../../../core/databases/readers/readers_prefs_data_source.dart';
import '../../../../core/entity/player/Reader.dart';
import '../../../../core/entity/player/ReaderAya.dart';
import '../../../../core/entity/player/SoraPageAyaInfo.dart';
import '../../../../core/entity/quran/Quran.dart';

abstract class PlayerDataSource{
  Future<SoraPageAyaInfo> getPagesOfSoraInRange(int soraNum,int ayaFrom,int ayaTo);
  Future<Reader?> getSelectedReader();
  Future<List<ZAYA>> getAyatOfSoraInRange(int soraNum,int ayaFrom,int ayaTo);//get reader inside
  Future<List<ZAYA>> getAyatFromDuration(int soraNum,double duration);
  Future<int?> getRepeatedAyaCount();
  Future<bool> saveRepeatedAyaCount(int rpAya);
  Future<int?> getRepeatedRangeCount();
  Future<bool> saveRepeatedRangeCount(int rpRange);
}

class PlayerDataSourceImpl extends PlayerDataSource{
  final ReadersPrefsDataSource readersPrefsDataSource;
  final RepeatDataSource repeatDataSource;

  PlayerDataSourceImpl({required this.readersPrefsDataSource,required this.repeatDataSource});

  @override
  Future<List<ZAYA>> getAyatOfSoraInRange(int soraNum, int ayaFrom, int ayaTo) async {
     int? readerID= await readersPrefsDataSource.getSelectedReader();
     return ReadersFloorDB.instance.database(readerID!).then((value) => value.readerDao.getSoraAyatInRange(soraNum, ayaFrom, ayaTo));
  }

  @override
  Future<List<ZAYA>> getAyatFromDuration(int soraNum, double duration) async{
    int? readerID= await readersPrefsDataSource.getSelectedReader();
    return ReadersFloorDB.instance.database(readerID!).then((value) => value.readerDao.getAyaFromDuration(duration, soraNum));
  }

  @override
  Future<SoraPageAyaInfo> getPagesOfSoraInRange(int soraNum, int ayaFrom, int ayaTo) async{
      Future<List<Quran>> ayat = QuranFloorDB.instance.database.then((value) => value.ayaDao.getAyatInRange(soraNum, ayaFrom, ayaTo));
      return ayat.then((value) => onGetAyatOfRange(value,soraNum));
  }

  @override
  Future<Reader?> getSelectedReader() async{
      var  reader = readersPrefsDataSource.getSelectedReader();
      return readers[reader];
  }

  onGetAyatOfRange(List<Quran> ayat,int sora) async {
    int firstPageNum = 0;
    if (ayat.isNotEmpty) {
      firstPageNum = ayat[0].PageNum;
    } else
      firstPageNum = 0;
    HashMap<int, List<int>> pagesMap = HashMap<int, List<int>>();
    HashMap<int, int> ayaPagesMap = HashMap<int, int>();
    for (final aya in ayat) {
      ayaPagesMap[aya.AyaNum] = aya.PageNum;
      List<int> ayaList = [];
      if (!pagesMap.containsKey(aya.PageNum)) {
        pagesMap[aya.PageNum] = ayaList;
      }
      ayaList.add(aya.AyaNum);
    }
    int pagesCount = pagesMap.length;
    return SoraPageAyaInfo(sora, firstPageNum, pagesCount, ayaPagesMap);
  }

  @override
  Future<int?> getRepeatedAyaCount() {
    return repeatDataSource.getRepeatedAyaCount();
  }

  @override
  Future<int?> getRepeatedRangeCount() {
    return repeatDataSource.getRepeatedRangeCount();
  }

  @override
  Future<bool> saveRepeatedAyaCount(int rpAya) {
    return repeatDataSource.saveRepeatedAyaCount(rpAya);
  }

  @override
  Future<bool> saveRepeatedRangeCount(int rpRange) {
    return repeatDataSource.saveRepeatedRangeCount(rpRange);
  }


}