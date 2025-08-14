import '../../../../core/databases/quran/QuranFloorDB.dart';
import '../../../../core/entity/quran/QuranPagesInfo.dart';

abstract class QuranPagesInfoSource{
  Future<QuranPagesInfo?> getPgeInfo(int page);
}

class QuranPagesInfoSourceImpl extends QuranPagesInfoSource{

  @override
  Future<QuranPagesInfo?> getPgeInfo(int page) {
    return QuranFloorDB.instance.database.then((value) => value.quranPagesInfoDao.getPageInfo(page));
  }
}