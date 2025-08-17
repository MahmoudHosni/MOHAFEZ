import '../../../../core/entity/quran/Sora.dart';
import '../repostories/FahresRepository.dart';

class SearchInSorasUsecase{
  final FahresRepository fahresRepo;

  SearchInSorasUsecase({required this.fahresRepo});

  Future<List<Sora>> call(String word){
    return fahresRepo.searchInSoras(word);
  }
}