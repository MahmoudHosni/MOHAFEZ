import 'package:floor/floor.dart';

@entity
class ZAYA{
  @primaryKey
  final int Z_PK;
  final int Z_ENT;
  final int Z_OPT;
  final int ZAYANUM;
  final int ZID;
  final int ZSTARTAYA;
  final int ZSORANUM;
  final int ZBASMALAH;
  final double ZFROMTIME;
  final double ZTOTIME;
  final String ZFILENAME;

  ZAYA({
    required this.Z_PK, required this.Z_ENT, required this.Z_OPT,
    required this.ZAYANUM, required this.ZID, required this.ZSTARTAYA, required this.ZSORANUM,
    required this.ZBASMALAH, required this.ZFROMTIME, required this.ZTOTIME, required this.ZFILENAME
  });
}