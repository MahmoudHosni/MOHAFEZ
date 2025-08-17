import '../../../../core/entity/player/ReaderAya.dart';
import '../repo/PlayerRepo.dart';

class GetRangeAyatInSoraUsecase{
  final PlayerRepo playerRepo;

  GetRangeAyatInSoraUsecase({required this.playerRepo});

  Future<List<ZAYA>> call(int soraNum,int ayaFrom,int ayaTo){
    return playerRepo.getAyatOfSoraInRange(soraNum, ayaFrom, ayaTo);
  }
}