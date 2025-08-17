
class Constants{
  static const String assetsFolder = "assets";
  static const String AyaBookmark = "AyaBookmark";
  static const String assetsImagesFolder = "$assetsFolder/drawables/";
  static const String assetsSvgsFolder = "$assetsFolder/svg/";
  static const String assetsSoraNamesFolder =  "$assetsFolder/sora_name/";
  static const String assetsQuranPagesFolder = "$assetsFolder/lines/";
  static const String assetsDatabasesFolder =  "$assetsFolder/databases/";
  static const String assetsSoundsFolder = "$assetsFolder/sounds/";
  static const String extensionMp3 = ".mp3";
  static const String soundsBaseUrl = "https://greatquran.net/download/sounds/";
  static const String arabicCode = "ar";
  static const String englishCode = "en";
  static const String MoyserDB = "MoyserDB";
  static const String QuranDB = "QuranDB";
  static const String SelectedReaderKey = "SelectedReaderKey";
  static const String RepeatedAyaKey = "RepeatedAyaKey";
  static const String RepeatedRangeKey = "RepeatedRangeKey";
  static const String LastPage = "LastPage";
  static const String fontSize = "fontSize";
  static const String Locale = "Locale";
  static const String DoublePages = "DoublePages";
  static const String DownloadSowarFolderName = "";
  // Constants for better maintainability
  static const double aspectRatioOffset = 0.1;
  static const double portraitTopOffset = -5.0;
  static const double landscapeTopOffset = -4.0;
  static const double leftPosAdjustment = -0.205;
  static const double leftValueAdjustment = -2.55;
  static const double landscapeMultiplier = 1.9;
  static const int specialPageThreshold = 2;
  static const double soraHeaderSizeReduction = 5.0;
  static const double defaultAspectRatioMultiplier = 40.0;
  // Portrait dimensions for early pages (PageNo <= 2)
  static const double portraitWidthEarly = 18.70;
  static const double portraitHeightEarly = 20.7;

  // Portrait dimensions for regular pages
  static const double portraitWidthRegular = 21.7;
  static const double portraitHeightRegular = 24.7;

  // Landscape dimensions for early pages
  static const double landscapeWidthEarly = 19.3;
  static const double landscapeHeightEarly = 21.3;

  // Landscape dimensions for regular pages
  static const double landscapeWidthRegular = 22.30;
  static const double landscapeHeightRegular = 25.3;

  static const double PageHeight = 2400;
  static const double PageWidth = 1120;
  static const double borderThicknessWidth = 0;//55; // 143;
  static const double borderThicknessHeight = 0;//55; //138;
  static const double borderThicknessHeightTablet=200;
  static const double borderThicknessWidthTablet = 200; // 143;
  static const String SlideImagePath = "";
  static const String SvgPath = "";
  static const String pngExtension = ".png";
  static const String playerNotificationIconName = "ic_stat_notifications" + pngExtension;

  static Map<String, List<double>> predefinedFilters = {
    'Identity': [
      //R  G   B    A  Const
      1, 0, 0, 0, 0, //
      0, 1, 0, 0, 0, //
      0, 0, 1, 0, 0, //
      0, 0, 0, 1, 0, //
    ],
    'Grey Scale': [
      //R  G   B    A  Const
      0.33, 0.59,0.11, 0,0,//
      0.33,0.59,0.11, 0,0,//
      0.33, 0.59,0.11, 0,0,//
      0, 0, 0, 1, 0, //
    ],
    'Invers': [
      //R  G   B    A  Const
      -1, 0, 0, 0, 255, //
      0, -1, 0, 0, 255, //
      0, 0, -1, 0, 255, //
      0, 0, 0, 1, 0, //
    ],
    'Sepia': [
      //R  G   B    A  Const
      0.393, 0.769, 0.189, 0,0, //
      0.349,0.686,0.168,   0,0, //
      0.272,0.534,0.131,0,0, //
      0, 0, 0, 1, 0, //
    ],
  };
}