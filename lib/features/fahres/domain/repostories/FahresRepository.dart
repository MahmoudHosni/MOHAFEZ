import '../../../../core/entity/quran/Juza.dart';
import '../../../../core/entity/quran/Quarter.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/entity/quran/Sora.dart';

abstract class FahresRepository{
  Future<List<Sora>>  getAllSoras();
  Future<List<Juza>>  getAllAjza();
  Future<List<MQuarter>>  getAllAjzaWithQuarters();
  Future<Sora?>       getSoraByID(int id);
  Future<Juza?>       getJuzaByID(int id);
  Future<List<Sora>>  searchInSoras(String word);
  Future<List<Juza>>  searchInAjza(String word);
  Future<Quran?>      getFirstAyaInSora(int soraNum);
  Future<List<Quran?>>      getFirstAyaInPage(int page);
}