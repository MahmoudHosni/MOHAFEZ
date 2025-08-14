import 'package:floor/floor.dart';
import '../../../entity/aya_position/AyaNumPosition.dart';

@dao
abstract class AyaPositionDao{
  @Query("select * from AyaNumPositions where PageNo=:page")
  Future<List<AyaNumPositions>> getAyatPositionsInPage(int page);

  @Query("select * from AyaNumPositions where PageNo>:minpage and PageNo<:maxpage")
  Future<List<AyaNumPositions>> getAyatPositionsInRange(int minpage,int maxpage);
}