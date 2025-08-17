import '../../../../core/entity/quran/Juza.dart';
import '../../../../core/entity/quran/Quarter.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/entity/quran/Sora.dart';
import '../data_sources/FahresLocalDataSource.dart';
import '../../domain/repostories/FahresRepository.dart';

class FahresRepositoryImpl implements FahresRepository{
  FahresDataSource dataSource;
  
  FahresRepositoryImpl({required this.dataSource});

  @override
  Future<List<Juza>> getAllAjza() {
    return dataSource.getAllAjza();
  }

  @override
  Future<List<Sora>> getAllSoras() {
    return dataSource.getAllSoras();
  }

  @override
  Future<Juza?> getJuzaByID(int id) {
    return dataSource.getJuzaByID(id);
  }

  @override
  Future<Sora?> getSoraByID(int id) {
    return dataSource.getSoraByID(id);
  }

  @override
  Future<List<Juza>> searchInAjza(String word) {
    return dataSource.searchInAjza(word);
  }

  @override
  Future<List<Sora>> searchInSoras(String word) {
    return dataSource.searchInSoras(word);
  }

  @override
  Future<List<MQuarter>> getAllAjzaWithQuarters() {
    return dataSource.getAllAjzaWithQuarters();
  }

  @override
  Future<Quran?> getFirstAyaInSora(int soraNum) {
    return dataSource.getFirstAyaInSora(soraNum);
  }

  @override
  Future<List<Quran?>> getFirstAyaInPage(int page) {
    return dataSource.getFirstAyaInPage(page);
  }


}