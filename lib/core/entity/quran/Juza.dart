import 'package:floor/floor.dart';

@entity
class Juza{
  @primaryKey
  final int JID;
  final String JuzaName;
  final String JuzaNum;
  final int PageNo;
  final int AyaNo;
  final String name_en;
  final int end_aya;

  const Juza ({
      required this.JID,
      required this.JuzaName,
      required this.JuzaNum,
      required this.PageNo,
      required this.AyaNo,
      required this.name_en,
      required this.end_aya
  });
}