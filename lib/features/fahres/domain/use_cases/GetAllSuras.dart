import '../../../../core/entity/quran/Sora.dart';
import '../repostories/FahresRepository.dart';

class GetAllSurasUsecase {
  final FahresRepository fahresRepo;

  GetAllSurasUsecase({required this.fahresRepo});

  Future<List<Sora>> call() {
    return fahresRepo.getAllSoras();
  }
}