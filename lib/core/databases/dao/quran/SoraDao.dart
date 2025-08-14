import 'package:floor/floor.dart';
import '../../../entity/quran/Sora.dart';

@dao
abstract class SoraDao{

  @Query("select * from Sora")
  Future<List<Sora>> getAllSoras();

  @Query("select * from Sora")
  Future<List<Sora>> getAllSorasAsFuture();

  @Query("select * from Sora where id=:id")
  Future<Sora?> getSoraByID(int id);

  @Query("select * from Sora where SearchText like :word")
  Future<List<Sora>> searchInSoras(String word);

  @Query(
      "SELECT distinct Id, Name, name_ar, AyatCount, PageNum, SearchText, name_en, Type, start_aya, end_aya "
          "FROM Sora WHERE ( SearchText like :text1 OR SearchText like :text2 OR SearchText like :text3 "
          "OR SearchText like :text4 OR SearchText like :text5 OR SearchText like :text6 "
          "OR name_en like :text1 OR name_en like :text2 OR name_en like :text3 "
          "OR name_en like :text4 OR name_en like :text5 OR name_en like :text6"
          ");")
  Future<List<Sora>> searchForSour(String text1, String text2, String text3, String text4, String text5, String text6);
}