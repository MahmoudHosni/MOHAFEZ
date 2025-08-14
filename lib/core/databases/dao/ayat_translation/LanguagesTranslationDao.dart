import 'package:floor/floor.dart';
import '../../../entity/ayat_trans/TranslationLanguage.dart';

@dao
abstract class LanguagesTranslationDao{
  @Query("SELECT * from Languages")
  Future<List<TranslationLanguage>> getLanguags();
}