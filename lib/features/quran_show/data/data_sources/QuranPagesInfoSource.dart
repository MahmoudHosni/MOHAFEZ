import '../../../../core/databases/quran/QuranFloorDB.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/entity/quran/QuranPagesInfo.dart';

abstract class QuranPagesInfoSource{
  Future<QuranPagesInfo?> getPgeInfo(int page);
  Future<Quran?> getAyaOf(int ayaNum,int soraNum);
}

class QuranPagesInfoSourceImpl extends QuranPagesInfoSource{

  @override
  Future<QuranPagesInfo?> getPgeInfo(int page) {
    return QuranFloorDB.instance.database.then((value) => value.quranPagesInfoDao.getPageInfo(page));
  }

  @override
  Future<Quran?> getAyaOf(int ayaNum, int soraNum) {
    return QuranFloorDB.instance.database.then((value) => value.ayaDao.getAyaOf(ayaNum, soraNum));
  }
}