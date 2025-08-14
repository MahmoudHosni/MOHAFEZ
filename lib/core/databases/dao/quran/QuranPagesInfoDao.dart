import 'package:floor/floor.dart';
import '../../../entity/quran/QuranPagesInfo.dart';

@dao
abstract class QuranPagesInfoDao{
  @Query("select * from QuranPagesInfo where PageNum=:no")
  Future<QuranPagesInfo?> getPageInfo(int no);
}