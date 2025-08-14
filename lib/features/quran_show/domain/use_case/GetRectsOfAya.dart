import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../repo/RectanglesRepo.dart';

class GetRectsOfAya{
  final RectanglesRepo rectanglesRepo;

  GetRectsOfAya({required this.rectanglesRepo});

  Future<List<ExportLine>> call(int aya,int sora){
    return rectanglesRepo.getRectsOfAya(aya,sora);
  }
}