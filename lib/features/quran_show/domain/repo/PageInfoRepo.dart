import '../../../../core/entity/quran/QuranPagesInfo.dart';

abstract class PageInfoRepo{
  Future<QuranPagesInfo?> getPageInfo(int page);
  bool isPagesRight();
  void savePage(int page);
  int getLastPageOpened();
}