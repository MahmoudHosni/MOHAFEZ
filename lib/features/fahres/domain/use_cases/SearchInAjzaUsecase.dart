import '../../../../core/entity/quran/Juza.dart';
import '../repostories/FahresRepository.dart';

class SearchInAjzaUsecase{
  final FahresRepository fahresRepo;

  SearchInAjzaUsecase({required this.fahresRepo});

  Future<List<Juza>> call(String word){
    return fahresRepo.searchInAjza(word);
  }
}