import 'package:mohafez/core/entity/quran/Quran.dart';
import 'package:mohafez/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/cache/DataPreference.dart';
import '../../../../core/entity/quran/QuranPagesInfo.dart';
import '../../domain/repo/PageInfoRepo.dart';
import '../data_sources/QuranPagesInfoSource.dart';

class PageInfoRepoImpl extends PageInfoRepo{
  final QuranPagesInfoSource quranPagesInfoSource;
  final Future<SharedPreferences> preference;

  PageInfoRepoImpl({ required this.quranPagesInfoSource ,required this.preference});

  @override
  Future<QuranPagesInfo?> getPageInfo(int page) {
      return quranPagesInfoSource.getPgeInfo(page);
  }

  @override
  bool isPagesRight() {
    return (DataPreference.getPreference()?.getString(Constants.Locale)?? "ar") =="en";
  }

  @override
  int getLastPageOpened() {
    return DataPreference.getPreference()?.getInt(Constants.LastPage)?? 1;
  }

  @override
  void savePage(int page) {
    DataPreference.getPreference()?.setInt(Constants.LastPage, page);
  }

  @override
  Future<Quran?> getAyaOf(int ayaNum, int soraNum) {
     return quranPagesInfoSource.getAyaOf(ayaNum, soraNum);
  }
}