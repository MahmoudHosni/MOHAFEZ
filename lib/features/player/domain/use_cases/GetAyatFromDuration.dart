import '../../../../core/entity/player/ReaderAya.dart';
import '../repo/PlayerRepo.dart';

class GetAyatFromDuration {
  final PlayerRepo playerRepo;

  GetAyatFromDuration({required this.playerRepo});

  Future<List<ZAYA>> call(int soraNum,double duration){
    return playerRepo.getAyatFromDuration(soraNum, duration);
  }
}