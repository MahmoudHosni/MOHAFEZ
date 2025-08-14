import 'package:flutter/widgets.dart';
import '../../../utils/app_util.dart';

class Reader{
  final int id;
  final String name_ar;
  final String name_en;
  final String image;
  final String soraUrl;
  final String ayaUrl;
  final int state;
  final bool hasSelection;

  Reader({required this.id,required this.name_ar,required this.name_en,required this.image,required this.soraUrl,required this.ayaUrl,required this.state,required this.hasSelection});

  String getName(BuildContext context) {
    if(isArabicLocale(context))
      {
        return name_ar;
      }
    else {
      return name_en;
    }
  }
}

final readers=  {
  1: Reader(id:1 ,name_ar: "عبد الرحمن السديس",name_en: "Sheikh Abdul Rahman Al-Sudais",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608117868.png",soraUrl: "https://server01.msaahef.net/abdullrahmanalsudais/m/",ayaUrl: "",state: 1,hasSelection:false),
  2: Reader(id:2 ,name_ar: "سعود بن إبراهيم الشريم",name_en: "Sheikh Saud Al-Shuraim ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608118277.png",soraUrl: "https://server02.msaahef.net/saudalshuraim/m/",ayaUrl: "",state: 1,hasSelection:true),
  3: Reader(id:3 ,name_ar: "عبد المحسن القاسم",name_en: "Sheikh AbdulMuhsin al-Qasim ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608114127.png",soraUrl: "https://server01.msaahef.net/abdulmuhsinalqasim/m/",ayaUrl: "",state: 1,hasSelection:false),
  4: Reader(id:4 ,name_ar: "ياسر الدوسري",name_en: "Sheikh Yasser_ad-Dussary ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608118058.png",soraUrl: "https://server02.msaahef.net/yasseraddussary/m/",ayaUrl: "",state: 1,hasSelection:true),
  5: Reader(id:5 ,name_ar: "ماهر المعيقلي",name_en: "Sheikh Maher Al-muaiqly ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608112700.png",soraUrl: "https://server01.msaahef.net/maheralmuaiqly/m/",ayaUrl: "",state: 1,hasSelection:true),
  6: Reader(id:6 ,name_ar: " ماهر المعيقلي – مجود",name_en: "Sheikh Maher Al-muaiqly_Mujawwad ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608112700.png",soraUrl: "https://server02.msaahef.net/muaiqlymujawwad/m/",ayaUrl: "",state: 1,hasSelection:false),
  7: Reader(id:7 ,name_ar: "علي بن عبد الرحمن الحذيفي",name_en: "Sheikh Ali Alhozaifi",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/hudhaifi.png",soraUrl: "https://server01.msaahef.net/alihlhozaifi/m/",ayaUrl: "",state: 1,hasSelection:false),
  8: Reader(id:8 ,name_ar: "سعد الغامدي",name_en: "Sheikh Saad AlGhamdi",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/alghamdi.png",soraUrl: "https://server02.msaahef.net/saadalghamdi/m/",ayaUrl: "",state: 1,hasSelection:false),
  9: Reader(id:9 ,name_ar: "عبد الله عواد الجهني",name_en: "Sheikh Abdallah AlJihny",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/jihani.png",soraUrl: "https://server01.msaahef.net/abdallahaljhny/m/",ayaUrl: "",state: 1,hasSelection:false),
  10: Reader(id:10 ,name_ar: "علي عبد الله جابر",name_en: "Sheikh Ali_Jaber ",image: "https://mashef.arabia-it.net/public/reciters/aligaber.png",soraUrl: "https://server02.msaahef.net/alijaber/m/",ayaUrl: "",state: 1,hasSelection:false),
  11: Reader(id:11 ,name_ar: "إبراهيم الأخضر",name_en: "Sheikh Ibrahim-Green ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/akhdar.png",soraUrl: "https://server01.msaahef.net/ibrahimakhder/m/",ayaUrl: "",state: 1,hasSelection:false),
  12: Reader(id:12 ,name_ar: "أبو بكر الشاطري",name_en: "Sheikh Abu_Bakr_Al-shatiry ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/shatere.png",soraUrl: "https://server02.msaahef.net/abubakralshatiry/m/",ayaUrl: "",state: 1,hasSelection:false),
  13: Reader(id:13 ,name_ar: "أحمد بن علي العجمي",name_en: "Sheikh Ahmed Al-Ajmy ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/ajami.png",soraUrl: "https://server01.msaahef.net/ahmadalajmy/m/",ayaUrl: "",state: 1,hasSelection:true),
  14: Reader(id:14 ,name_ar: "خليفة الطنيجي",name_en: "Sheikh Khalifa A-tunaiji",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/tanaje.png",soraUrl: "https://server02.msaahef.net/khalifaaltunaiji/m/",ayaUrl: "",state: 1,hasSelection:false),
  15: Reader(id:15 ,name_ar: "بندر بليله",name_en: "Sheikh Bander_Baleelah ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/bnder.png",soraUrl: "https://server01.msaahef.net/banderbaleelah/m/",ayaUrl: "",state: 1,hasSelection:false),
  16: Reader(id:16 ,name_ar: "عبد الودود بن مقبول حنيف",name_en: "Sheikh abdulwadood Haneef",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/makbol.png",soraUrl: "https://server02.msaahef.net/abdulwadoodhaneef/m/",ayaUrl: "",state: 1,hasSelection:false),
  17: Reader(id:17 ,name_ar: "محمد أيوب بن محمد يوسف",name_en: "Sheikh Mohammed Ayyub",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608112975.png",soraUrl: "https://server01.msaahef.net/mohamedayoub/m/",ayaUrl: "",state: 1,hasSelection:false),
  18: Reader(id:18 ,name_ar: "ناصر القطامي",name_en: "Sheikh Nasser Al-Qatami ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608117781.png",soraUrl: "https://server02.msaahef.net/nasseralqatami/m/",ayaUrl: "",state: 1,hasSelection:true),
  19: Reader(id:19 ,name_ar: "مشاري راشد العفاسي",name_en: "Sheikh mshary Al3afasy ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/1608118171.png",soraUrl: "https://server01.msaahef.net/msharyal3afasy/m/",ayaUrl: "",state: 1,hasSelection:false),

  24: Reader(id:24 ,name_ar: "صابر عبد الحكم - حفص بالتوسط",name_en: " حفص عن عاصم بالتوسط- صابر عبد الحكم ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server02.msaahef.net/sahfstwasat/m/",ayaUrl: "",state: 1,hasSelection:false),
  25: Reader(id:25 ,name_ar: "صابر عبد الحكم - حفص بالقصر",name_en: " حفص عن عاصم بالقصر- صابر عبد الحكم ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server01.msaahef.net/sahfsqasar/m/",ayaUrl: "",state: 1,hasSelection:false),
  26: Reader(id:26 ,name_ar: "صابر عبد الحكم - شعبة",name_en: " شعبة عن عاصم - صابر عبد الحكم ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server02.msaahef.net/sashoba/m/",ayaUrl: "",state: 1,hasSelection:false),
  27: Reader(id:27 ,name_ar: "صابر عبد الحكم - الدوري عن أبي عمرو بالتوسط",name_en: " صابر عبد الحكم- دورى عن أبي عمرو بالتوسط ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server01.msaahef.net/saaboamrotwasat/m/",ayaUrl: "",state: 1,hasSelection:false),
  28: Reader(id:28 ,name_ar: "صابر عبد الحكم - السوسي",name_en: " سوسي عن أبي عمرو - صابر عبد الحكم ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server02.msaahef.net/sasusiaboamro/m/",ayaUrl: "",state: 1,hasSelection:false),
  29: Reader(id:29 ,name_ar: "صابر عبد الحكم - قالون بالقصر مع السكون",name_en: " صابر عبد الحكم - قالون عن نافع بالقصر مع السكون ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server01.msaahef.net/saqqasarsokon/m/",ayaUrl: "",state: 1,hasSelection:false),
  30: Reader(id:30 ,name_ar: "صابر عبد الحكم - قالون بالقصر مع الصلة",name_en: " صابر عبد الحكم - قالون عن نافع بالقصر مع الصلة ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server02.msaahef.net/saqqsela/m/",ayaUrl: "",state: 1,hasSelection:false),
  31: Reader(id:31 ,name_ar: "صابر عبد الحكم - ورش",name_en: " صابر عبد الحكم - ورش عن نافع ",image: "https://arabiaapi.com/sakina/public/uploads/images/reciters/saber.png",soraUrl: "https://server01.msaahef.net/sawarash/m/",ayaUrl: "",state: 1,hasSelection:false),
};

List<Reader> createReaders() {
  List<Reader> readersList = [];
  readers.forEach((key, value) {
    //Here you have key and value for each item in your map but you can't break the loop
    //to avoid unnecessary iterations.
    //This approach is only useful when you need to perform changes in all Map items.
    readersList.add(value);
  });
  return readersList;
}

