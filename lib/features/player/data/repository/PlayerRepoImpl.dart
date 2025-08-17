import '../../../../core/entity/player/Reader.dart';
import '../../../../core/entity/player/ReaderAya.dart';
import '../../../../core/entity/player/SoraPageAyaInfo.dart';
import '../../domain/repo/PlayerRepo.dart';
import '../data_sources/PlayerDataSource.dart';

class PlayerRepoImpl extends PlayerRepo{
  final PlayerDataSource playerDataSource;

  PlayerRepoImpl({required this.playerDataSource});

  @override
  Future<Reader?> getSelectedReader() {
    return playerDataSource.getSelectedReader();
  }

  @override
  Future<List<ZAYA>> getAyatOfSoraInRange(int soraNum, int ayaFrom, int ayaTo) {
    return playerDataSource.getAyatOfSoraInRange(soraNum, ayaFrom, ayaTo);
  }

  @override
  Future<List<ZAYA>> getAyatFromDuration(int soraNum, double duration) {
    return playerDataSource.getAyatFromDuration(soraNum, duration);
  }

  @override
  Future<SoraPageAyaInfo> getPagesOfSoraInRange(int soraNum, int ayaFrom, int ayaTo) {
    return playerDataSource.getPagesOfSoraInRange(soraNum, ayaFrom, ayaTo);
  }

  @override
  Future<int?> getRepeatedAyaCount() {
    return playerDataSource.getRepeatedAyaCount();
  }

  @override
  Future<int?> getRepeatedRangeCount() {
    return playerDataSource.getRepeatedRangeCount();
  }

  @override
  Future<bool> saveRepeatedAyaCount(int rpAya) {
    return playerDataSource.saveRepeatedAyaCount(rpAya);
  }

  @override
  Future<bool> saveRepeatedRangeCount(int rpRange) {
    return playerDataSource.saveRepeatedRangeCount(rpRange);
  }
}