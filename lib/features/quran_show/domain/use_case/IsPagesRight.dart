import '../repo/PageInfoRepo.dart';

class IsPagesRight{
  final PageInfoRepo pageInfoRepo;

  IsPagesRight({required this.pageInfoRepo});

  bool call(){
    return pageInfoRepo.isPagesRight();
  }
}