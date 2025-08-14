import 'package:floor/floor.dart';
import '../../../entity/player/ReaderAya.dart';

@dao
abstract class ReaderDao{
  @Query("select * from ZAYA where ZSORANUM =:soraNum and ZAYANUM >=:ayaFrom and ZAYANUM <=:ayaTo")
  Future<List<ZAYA>> getSoraAyatInRange(int soraNum,int ayaFrom,int ayaTo);

  @Query("select * from ZAYA where ZSORANUM =:soraNum and ZFROMTIME >=:dr")
  Future<List<ZAYA>> getAyaFromDuration(double dr,int soraNum,);
}