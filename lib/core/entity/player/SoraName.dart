import 'package:flutter/widgets.dart';
import '../../../features/quran_show/domain/quran_util/QuranUtils.dart';
import '../../../utils/app_util.dart';

class SoraName{
  final int soraNum;
  final String name_ar;
  final String name_en;

  SoraName({required this.soraNum,required this.name_ar,required this.name_en});

  String getName(BuildContext context) {
    if(isArabicLocale(context))
      {
        return name_ar;
      }
    else
      return name_en;
  }
}

List<SoraName> createAllSowar() {
  List<SoraName> list = [];
  for (var soraNum = 1; soraNum <= 114; soraNum++) {
    list.add(SoraName(soraNum: soraNum, name_ar: QuranUtils.ArabicSoraNames()[soraNum-1],
        name_en: QuranUtils.EnglishSoraNames()[soraNum-1]));
  }
  return list;
}
