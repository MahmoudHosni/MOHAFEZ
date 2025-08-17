import '../../../../core/entity/quran/Juza.dart';
import '../repostories/FahresRepository.dart';

class GetJuzaUsecase{
  final FahresRepository fahresRepo;

  GetJuzaUsecase({required this.fahresRepo});

  Future<Juza?> call(int id) {
    return fahresRepo.getJuzaByID(id);
  }
}