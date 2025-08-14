import 'package:floor/floor.dart';
import '../../../entity/quran/Quarter.dart';

@dao
abstract class QuarterDao{
  @Query("SELECT * from  Quarter")
  Future<List<MQuarter>> GetAllQuarters();

  @Query("select * from Quarter where Part =:part")
  Future<List<MQuarter>> getQuartersByPartNo(int part);

  @Query("select * from Quarter where Hezb =:hezp")
  Future<List<MQuarter>>  getQuartersByHezpNo(int hezp);

  @Query("select * from Quarter where Quarter =:quarter")
  Future<List<MQuarter>> getQuartersByQuarterNo(int quarter);

  @Query("select * from Quarter where AyaId =:ayaId")
  Future<List<MQuarter>> getQuarterByAyaId(int ayaId);

  @Query("SELECT Quarter.Id,(Quarter.Part),Quarter.Hezb,Quarter.Quarter,Quarter.AyaId from Quarter where Quarter.Part in (SELECT DISTINCT(Quarter.Part) from Quarter) and Quarter.Hezb % 2=1 and Quarter.Quarter=1 ")
  Future<List<MQuarter>> getAllAjza();

  @Query("select * from Quarter where Quarter.Id = :quarterNo")
  Future<MQuarter?>  getQuarterById(int quarterNo);
 }