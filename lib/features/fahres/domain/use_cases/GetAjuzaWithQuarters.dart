import '../../../../core/entity/quran/Quarter.dart';
import '../repostories/FahresRepository.dart';

class GetAjuzaWithQuarters{
  final FahresRepository fahresRepo;

  GetAjuzaWithQuarters({required this.fahresRepo});

  Future<List<MQuarter>> call(){
    return fahresRepo.getAllAjzaWithQuarters();
  }
}