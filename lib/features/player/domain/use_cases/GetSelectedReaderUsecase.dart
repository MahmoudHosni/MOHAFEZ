import '../../../../core/entity/player/Reader.dart';
import '../repo/PlayerRepo.dart';

class GetSelectedReaderUsecase {
  final PlayerRepo playerRepo;

  GetSelectedReaderUsecase({required this.playerRepo});

  Future<Reader?> call(){
    return playerRepo.getSelectedReader();
  }
}