import '../../../../core/entity/quran/Quran.dart';
import '../repo/PageInfoRepo.dart';

class GetAyatOfSora{
  final PageInfoRepo pageInfoRepo;

  GetAyatOfSora({required this.pageInfoRepo});

  Future<List<Quran?>> call(int soraId,int start,int end){
    return pageInfoRepo.getAyatOfSora(soraId,start,end);
  }
}