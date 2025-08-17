import '../../../../core/entity/quran/Juza.dart';
import '../repostories/FahresRepository.dart';

class GetAllAjzaUsecase{
  final FahresRepository fahresRepo;

  GetAllAjzaUsecase({required this.fahresRepo});

  Future<List<Juza>> call() async{
    return await fahresRepo.getAllAjza();
  }
}