import 'package:floor/floor.dart';

@entity
class AyaTranslation{
  @primaryKey
  final int ItemID;
  final String ItemText;
  final int ItemType;
  final String Footnotes;
  final int PageNum;
  final int SuraNum;
  final int Sort;

  AyaTranslation({required this.ItemID,required this.ItemText,required this.ItemType,required this.Footnotes,
               required this.PageNum,required this.SuraNum,required this.Sort });
}