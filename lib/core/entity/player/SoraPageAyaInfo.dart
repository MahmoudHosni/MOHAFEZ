import 'dart:collection';

class SoraPageAyaInfo {
  final int soraNum;
  final int firstPageNum;
  final int pagesCount;
  final HashMap<int, int> ayaPageMap;

  SoraPageAyaInfo(this.soraNum, this.firstPageNum, this.pagesCount, this.ayaPageMap);
}