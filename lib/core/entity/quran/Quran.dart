import 'package:floor/floor.dart';

@entity
class Quran{
  @primaryKey
  final int ID;
  final int SoraNum;
  final int AyaNum;
  final int PageNum;
  final int PartNum;
  final int sign_type;
  final String search_text;
  final String SoraName;
  final String SoraName_en;
  final String AyaDiac;
  final String AyaNoDiac;
  final String trans_en;

   Quran(
     this.ID,
     this.PageNum,
     this.AyaDiac,
     this.AyaNoDiac,
     this.AyaNum,
     this.PartNum,
     this.search_text,
     this.sign_type,
     this.SoraName,
     this.SoraName_en,
     this.SoraNum,
     this.trans_en
  );

}