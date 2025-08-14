import 'package:floor/floor.dart';

import 'Quran.dart';

@Entity(tableName:  "Quarter")
class MQuarter{
  @primaryKey
  final int Id;
  final int Part;
  final int Hezb;
  final int AyaId;
  final int Quarter;
  @ignore Quran?  aya  = null;
  @ignore var endPageNo = 0;

  MQuarter({required this.Id,required this.Part,required this.Hezb,required this.AyaId,required this.Quarter});
}