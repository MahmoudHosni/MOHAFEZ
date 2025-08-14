import '../../../../core/entity/aya_position/AyaNumPosition.dart';

abstract class AyatPositionRepo{
  Future<List<AyaNumPositions>> getPositionsOfAyatInPage(int page);
  Future<List<AyaNumPositions>> getPositionsOfAyatInRange(int start,int end);
}