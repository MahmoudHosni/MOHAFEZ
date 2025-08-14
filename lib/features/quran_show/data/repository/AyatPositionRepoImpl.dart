import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../features/quran_show/domain/repo/AyatPositionRepo.dart';
import '../../../../features/quran_show/data/data_sources/AyatPositionDataSource.dart';

class AyatPositionRepoImpl extends AyatPositionRepo{
  final AyatPositionDataSource ayatPositionDataSource;

  AyatPositionRepoImpl({required this.ayatPositionDataSource});

  @override
  Future<List<AyaNumPositions>> getPositionsOfAyatInPage(int page) {
    return ayatPositionDataSource.getPositionsOfAyatInPage(page);
  }

  @override
  Future<List<AyaNumPositions>> getPositionsOfAyatInRange(int start,int end) {
    return ayatPositionDataSource.getPositionsOfAyatInRange(start,end);
  }
}