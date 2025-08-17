import '../../../../core/entity/quran/Quran.dart';
import '../repostories/FahresRepository.dart';

class GetFirstAyaInPageUsecase{
  final FahresRepository fahresRepo;

  GetFirstAyaInPageUsecase({required this.fahresRepo});

  Future<List<Quran?>> call(int page) {
    return fahresRepo.getFirstAyaInPage(page);
  }
}