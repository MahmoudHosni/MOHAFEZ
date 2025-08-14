import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../features/quran_show/domain/repo/AyatPositionRepo.dart';

class GetAyatPositionsInRange{
  final AyatPositionRepo ayatPositionRepo;

  GetAyatPositionsInRange({required this.ayatPositionRepo});

  Future<List<AyaNumPositions>> call(int start,int end){
    return ayatPositionRepo.getPositionsOfAyatInRange(start, end);
  }
}