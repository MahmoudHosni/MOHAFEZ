import '../../../../core/entity/quran/Sora.dart';
import '../repostories/FahresRepository.dart';

class GetSoraUsecase{
  final FahresRepository fahresRepo;

  GetSoraUsecase({required this.fahresRepo});

  Future<Sora?> call(int id) {
    return fahresRepo.getSoraByID(id);
  }
}