import 'package:floor/floor.dart';

@entity
class QuranPagesInfo{
  @primaryKey
  final int PageNum ;
  final int PartNum ;
  final int HezbNum ;
  final int RubNum ;

  const QuranPagesInfo({
      required this.PageNum,
      required this.PartNum,
      required this.HezbNum,
      required this.RubNum
  });
}