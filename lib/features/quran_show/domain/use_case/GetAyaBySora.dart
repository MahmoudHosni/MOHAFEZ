import 'package:mohafez/core/entity/quran/Quran.dart';
import '../repo/PageInfoRepo.dart';

class GetAyaBySora {
  final PageInfoRepo pageInfoRepo;

  GetAyaBySora({required this.pageInfoRepo});

  Future<Quran?> call(int soraId,int ayaID){
    return pageInfoRepo.getAyaOf(ayaID,soraId);
  }
}