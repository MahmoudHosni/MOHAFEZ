import '../../../../core/entity/player/SoraPageAyaInfo.dart';
import '../repo/PlayerRepo.dart';

class GetSoraPagesInRangeUsecase{
  final PlayerRepo playerRepo;

  GetSoraPagesInRangeUsecase({required this.playerRepo});

  Future<SoraPageAyaInfo> call(int soraNum,int ayaFrom,int ayaTo){
    return playerRepo.getPagesOfSoraInRange(soraNum, ayaFrom, ayaTo);
  }
}