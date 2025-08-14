import '../repo/PageInfoRepo.dart';

class GetLastPageOpenedUsecase{
  final PageInfoRepo pageInfoRepo;

  GetLastPageOpenedUsecase({required this.pageInfoRepo});

  int call(){
    return pageInfoRepo.getLastPageOpened();
  }
}