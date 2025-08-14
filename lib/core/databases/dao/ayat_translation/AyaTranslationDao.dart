import 'package:floor/floor.dart';
import '../../../entity/ayat_trans/AyaTranslation.dart';

@dao
abstract class AyaTranslationDao{

  @Query("SELECT * from Translation WHERE ItemID = (select ItemID from TranslationAyat where AyaID =:ayaID")
  Future<List<AyaTranslation>> getTranslationOfAya(int ayaID);


}