import 'package:floor/floor.dart';

@entity
class ExportLine{
  @primaryKey
  final int RecID;
  final int AyaNum;
  final int SoraID;
  final int PageNo;
  final int LineNum;
  final int X;
  final int Y;
  final int XMax;
  final int YMax;

  ExportLine({
    required this.RecID,
    required this.AyaNum,
    required this.SoraID,
    required this.PageNo,
    required this.LineNum,
    required this.X,
    required this.Y,
    required this.XMax,
    required this.YMax
  });
}