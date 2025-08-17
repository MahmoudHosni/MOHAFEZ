import '../../../../core/entity/player/Reader.dart';
import '../../../../core/entity/player/ReaderAya.dart';
import '../../../../core/entity/player/SoraPageAyaInfo.dart';

abstract class PlayerRepo{
  Future<SoraPageAyaInfo> getPagesOfSoraInRange(int soraNum,int ayaFrom,int ayaTo);
  Future<Reader?> getSelectedReader();
  Future<List<ZAYA>> getAyatOfSoraInRange(int soraNum,int ayaFrom,int ayaTo);//get reader inside
  Future<List<ZAYA>> getAyatFromDuration(int soraNum,double duration);
  Future<int?> getRepeatedAyaCount();
  Future<bool> saveRepeatedAyaCount(int rpAya);
  Future<int?> getRepeatedRangeCount();
  Future<bool> saveRepeatedRangeCount(int rpRange);
}