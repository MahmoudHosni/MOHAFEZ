import 'package:floor/floor.dart';

@entity
class AyaNumPositions{
  @primaryKey
  final int AyaID;
  final int AyaNum;
  final int SoraID;
  final int PageNo;
  final int? X;
  final int? Y;
  final int? XMax;
  final int? YMax;
  final double? MatchRatio;
  final int? LineNum;

  AyaNumPositions(this.AyaID,this.AyaNum,this.SoraID,this.PageNo,this.X,this.Y,this.XMax,this.YMax,this.MatchRatio,this.LineNum);
}