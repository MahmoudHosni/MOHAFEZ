import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import 'dynamic_aya_num.dart';
import 'package:flutter/material.dart';

class QuranPageUtil {

  static List<DynamicAyaNum> getAyaNumListViews(List<AyaNumPositions> ayaNumPositions) {
    List<DynamicAyaNum> list=[];
    for (final pos in ayaNumPositions) {
      if (pos.AyaNum == 0) {
        DynamicAyaNum soraWidget = DynamicAyaNum(ayaPosition: pos, orientation: Orientation.portrait,scale: 1,scaleRatio: 1,);
        list.add(soraWidget);
        continue;
      }
      DynamicAyaNum ayaNumWidget = DynamicAyaNum(ayaPosition: pos, orientation: Orientation.portrait,scale: 1,scaleRatio: 1,);
      list.add(ayaNumWidget);
    }
    return list;
  }

  static DynamicAyaNum? getAyaNumToHighlight( List<Widget> ayaNumViews ,int soraNum,int ayaNum){
    DynamicAyaNum? ayaNumView ;
    for (var i = 0; i < ayaNumViews.length; i++) {
      if (((ayaNumViews[i] as DynamicAyaNum).ayaPosition.SoraID == soraNum) &&
          ((ayaNumViews[i] as DynamicAyaNum).ayaPosition.AyaNum == ayaNum)) {
        ayaNumView = ayaNumViews[i] as DynamicAyaNum;
        break;
      }
    }
    return ayaNumView ;
  }

  static List<AyaNumPositions> getCurrentSoraAyaNums(List<AyaNumPositions> ayaNumPositions,int soraNum , int pageNum) {
    List<AyaNumPositions> currentSoraAyaNumsPositions = [];
    for (final ayaNumPos in ayaNumPositions) {
      if (ayaNumPos.SoraID == soraNum
          && ayaNumPos.PageNo == pageNum) {
        currentSoraAyaNumsPositions.add(ayaNumPos);
      }
    }
    currentSoraAyaNumsPositions.sort((a, b) => a.AyaNum.compareTo(b.AyaNum));
    return currentSoraAyaNumsPositions ;
  }

  static String replaceEnglishNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }
}