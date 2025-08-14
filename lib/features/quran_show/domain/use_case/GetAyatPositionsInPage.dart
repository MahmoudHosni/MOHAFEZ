import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../features/quran_show/domain/repo/AyatPositionRepo.dart';

class GetAyatPositionsInPage{
  final AyatPositionRepo ayatPositionRepo;

  GetAyatPositionsInPage({required this.ayatPositionRepo});

  Future<List<AyaNumPositions>> call(int page){
    return ayatPositionRepo.getPositionsOfAyatInPage(page);
  }
}