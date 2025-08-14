import 'package:floor/floor.dart';
import '../../../entity/quran/Juza.dart';

@dao
abstract class JuzaDao{

  @Query("select * from Juza")
  Future<List<Juza>> getAllAjza();

  @Query("select * from Juza where JID=:id")
  Future<Juza?> getJuzaByID(int id);

  @Query("select * from Juza where SearchText like :word")
  Future<List<Juza>> searchInAjza(String word);
}