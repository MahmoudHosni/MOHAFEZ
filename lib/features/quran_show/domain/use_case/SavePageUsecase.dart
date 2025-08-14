import '../repo/PageInfoRepo.dart';

class SavePageUsecase{
  final PageInfoRepo pageInfoRepo;

  SavePageUsecase({required this.pageInfoRepo});

  void call(int page){
    pageInfoRepo.savePage(page);
  }
}