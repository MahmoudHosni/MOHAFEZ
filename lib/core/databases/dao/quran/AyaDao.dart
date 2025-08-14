import '../../../entity/quran/Quran.dart';
import 'package:floor/floor.dart';

@dao
abstract class AyaDao{
  @Query("select * FROM Quran WHERE AyaNum between :staya and :endaya and SoraNum=:sora")
  Future<List<Quran>> getAyatInRange(int sora,int staya,int endaya);

  @Query("select * FROM Quran WHERE ID between :staya and :endaya")
  Future<List<Quran>> getAyat(int staya,int endaya);

  @Query("select * FROM Quran WHERE ID=:ayaID")
  Future<Quran?> getAyaByID(int ayaID);

  @Query("select * FROM Quran WHERE ID between :startAyaID and :endAyaID")
  Future<List<Quran?>> getAyatByID(int startAyaID,int endAyaID);

  @Query("select * FROM Quran WHERE AyaNum=:ayaNum and SoraNum=:soraNum")
  Future<Quran?> getAyaOf(int ayaNum,int soraNum);

  @Query("select * from Quran where PageNum=:page")
  Future<List<Quran>> getAyatInPage(int page);

  @Query("select * FROM Quran WHERE AyaNoDiac like :word")
  Future<List<Quran>> searchAyat(String word);

  @Query("SELECT * FROM Quran WHERE ID IN (:ids)  ORDER BY ID;")
  Future<List<Quran>> getAyatByIDS(List<int> ids);

  @Query("select * from Quran where ID in (select aya_ID from favourite)")
  Future<List<Quran>> getFavouriteAyat();

  @Query("select * from Quran where ID in (select aya_ID from bookmark)")
  Future<List<Quran>> getBookmarkAyat();

  @Query(
      "SELECT distinct ID, SoraNum, AyaNum, PageNum, SoraName, SoraName_en, AyaDiac, AyaNoDiac, search_text, PartNum, trans_en, sign_type "
          "FROM Quran WHERE ( search_text like :text1 OR search_text like :text2 OR search_text like :text3 "
          "OR search_text like :text4 OR search_text like :text5 OR search_text like :text6 );")
  Future<List<Quran>> searchForAyat(String text1, String text2, String text3, String text4, String text5, String text6);

  @Query('select * from Quran where ID = (select AyaId from Quarter where Id = :quarterId)')
  Future<Quran?> getFirstAyaFor(int quarterId);

  @Query('select * from Quran where ID = (select AyaId from Quarter where Id = :quarterId) - 1')
  Future<Quran?> getLastAyaFor(int quarterId);

  @Query('select * from Quran where ID = 6236')
  Future<Quran?> getLastAyaInQuran();

  @Query('select * from Quran where PartNum=:part ORDER by ID ASC limit 1')
  Future<Quran?> getFirstAyaInPart(int part);
}