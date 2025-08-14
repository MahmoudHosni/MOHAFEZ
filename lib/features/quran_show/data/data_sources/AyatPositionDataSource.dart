import '../../../../core/databases/positions/AyatPositionsFloorDB.dart';
import '../../../../core/entity/aya_position/AyaNumPosition.dart';

abstract class AyatPositionDataSource{
  Future<List<AyaNumPositions>> getPositionsOfAyatInPage(int page);
  Future<List<AyaNumPositions>> getPositionsOfAyatInRange(int start,int end);
}

class AyatPositionDataSourceImpl extends AyatPositionDataSource{

  @override
  Future<List<AyaNumPositions>> getPositionsOfAyatInPage(int page) {
    return AyatPositionsFloorDB.instance.database.then((value) => value.ayaPositionDao.getAyatPositionsInPage(page));
  }

  @override
  Future<List<AyaNumPositions>> getPositionsOfAyatInRange(int start,int end) {
    return AyatPositionsFloorDB.instance.database.then((value) => value.ayaPositionDao.getAyatPositionsInRange(start,end));
  }
}