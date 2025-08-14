import '../../../../core/entity/quran/QuranPagesInfo.dart';
import '../repo/PageInfoRepo.dart';

class GetPageInfo{
  final PageInfoRepo pageInfoRepo;

  GetPageInfo({required this.pageInfoRepo});

  Future<QuranPagesInfo?> call(int page){
    return pageInfoRepo.getPageInfo(page);
  }
}