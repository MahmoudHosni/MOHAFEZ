import 'package:flutter/material.dart';

extension CustomThemeDataExt on ThemeData {

  Color get timeBorder =>
      brightness == Brightness.light
          ? const Color(0xffdbdbdb)
          : const Color(0xff394d7f);

  Color get timeDays => const Color(0xff4D6EC3);

  Color get timeLabel =>
      brightness == Brightness.light
          ? const Color(0xff252525)
          : const Color(0xfffdfdfd);

  Color get MoshafBG => brightness ==Brightness.light
      ? const Color(0xffFFF8EE)
      : const Color(0xff24345d);

  Color get MoshafBG2 => brightness ==Brightness.light
      ? const Color(0xffFFF9F1)
      : const Color(0xff0D0D0D);

  Color get MoshafColor => brightness == Brightness.light?
        const Color(0xffB3916C) : const Color(0xff515151);

  Color get cardBG => brightness == Brightness.light
      ? const Color(0xffF5F5F5)
      : const Color(0xff1a1a1a);//0xff394D7F

  Color get cardBG2 => brightness == Brightness.light
      ? const Color(0xffF5F5F5)
      : const Color(0xff1a1a1a);

  Color get soraPlayerBg => brightness == Brightness.light
      ? const Color(0xffF2F2F2)
      : const Color(0xff1a1a1a);

  Color get bannerDetailsBg => brightness == Brightness.light
      ? const Color(0xfffdfdfd)
      : const Color(0xff121212);

  Color get selectedText => brightness == Brightness.light
      ? const Color(0xff4d6ec3)
      : const Color(0xfffdfdfd);

  Color get selectedTextDark => brightness == Brightness.light
      ? const Color(0xff394d7f)
      : const Color(0xfffdfdfd);

  Color get bannerDetailsPortraitBgSelected => Colors.transparent ;
  Color get bannerDetailsPortraitBgUnSelected => brightness == Brightness.light
      ? const Color(0xfff5f5f5)
      : Colors.transparent;

  Color get bannerDetailsPortraitBorderSelected => const Color(0xff4d6ec3);
  Color get bannerDetailsPortraitBorderUnSelected => brightness == Brightness.light
      ? const Color(0xffdbdbdb)
      : const Color(0xff394d7f);

  Color get bannerDetailsLandscapeBgSelected => brightness == Brightness.light
      ? const Color(0xffffffff)
      : Colors.transparent;

  Color get bannerDetailsLandscapeBgUnSelected => brightness == Brightness.light
      ? const Color(0xfff5f5f5)
      : Colors.transparent;

  Color get bannerDetailsLandscapeBorderSelected => const Color(0xff4d6ec3);

  Color get bannerDetailsLandscapeBorderUnSelected => brightness == Brightness.light
      ? const Color(0xffdbdbdb)
      : const Color(0xff394d7f);


  Color get bannerDetailsShareBg => const Color(0xff4d6ec3);

  Color get bannerDetailsShareTxt => const Color(0xfffdfdfd);

  Color get bannerDetailsBackBg => Colors.transparent ;

  Color get bannerDetailsBackBorder => brightness == Brightness.light
      ? const Color(0xffdbdbdb)
      : const Color(0xff4d6ec3);

  Color get bannerDetailsBackTxt => const Color(0xff4d6ec3);

  Color get searchTxtHint => const Color(0xffBEC0C1) ;
  Color get searchTxt => const Color(0xffBEC0C1) ;
  Color get searchBg => brightness == Brightness.light
      ? const Color(0xfff5f5f5)
      : const Color(0xff394d7f);

  Color get readersDownIconBg => const Color(0xff4d6ec3);

  Color get readersSelectTxt => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get readersSearchIconBg => const Color(0xffBEC0C1) ;

  String get readersSlideIconName => brightness == Brightness.light
      ? 'ic_slide'
      : 'ic_slide_dark';

  String get boobPartIconName => brightness == Brightness.light ? 'ic_bookpart.svg' : 'ic_bookpart-dart.svg';

  Color get blackWithGray => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xffBEC0C1);

  Color get seekbarBG => brightness == Brightness.light
      ? const Color(0xffCACACA)
      : const Color(0xffCACACA);
  //background: #CACACA;

  Color get blackWithWhite => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get blackWithGrayDark => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xff888888);

  Color get readersCellName => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get readersCellDivider => brightness == Brightness.light
      ? const Color(0xffdbdbdb)
      : const Color(0xff394d7f);

  Color get selectionsHomeLabel => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get selectionsHomeAllLabel => const Color(0xff4d6ec3);

  Color get selectionsHomeCellTitle => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get selectionsHomeCellReciterName => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get selectionsAllBg => brightness == Brightness.light
      ? const Color(0xfffdfdfd)
      : const Color(0xff24345d);

  Color get selectionsAllLabel => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get selectionsAllCellTitle => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get selectionsAllCellReciterName => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get moreCardBG => brightness == Brightness.light
      ? const Color(0xfff5f5f5)
      : const Color(0xff394d7f);

  Color get moreCard => brightness == Brightness.light
      ? const Color(0xffffffff)
      : const Color(0xff394d7f);

  Color get separator =>
      brightness == Brightness.light
          ? const Color(0xffdbdbdb)
          : const Color(0xff394d7f);

  Color get separator2 =>
      brightness == Brightness.light
          ? const Color(0xffdbdbdb)
          : const Color(0xff24345d);

  Color get separator3 =>
      brightness == Brightness.light
          ? const Color(0xffE2E2E2)
          : const Color(0xff666666);

  Color get progressIndicator => brightness == Brightness.light
      ? const Color(0xff4d6ec3)
      : const Color(0xfffdfdfd);

  Color get bookViewBG => brightness == Brightness.light
      ? const Color(0xffF9F5F1)
      : const Color(0xff24345d);

  Color get selectionDetailsBg => const Color(0xff24345d);

  Color get selectionDetailsTitle => const Color(0xfffdfdfd);

  Color get selectionDetailsReciterName => const Color(0xfffdfdfd);

  Color get notesBg => brightness == Brightness.light
      ? const Color(0xfffdfdfd)
      : const Color(0xff24345d);

  Color get notesCellBg => brightness == Brightness.light
      ? const Color(0xffF5F5F5)
      : const Color(0xff394D7F);

  Color get notesCellText => brightness == Brightness.light
      ? const Color(0xff252525)
      : const Color(0xfffdfdfd);

  Color get black =>
      brightness==Brightness.light? const Color(0xFF000000) : const Color(0xFFffffff);

  Color get blackTitles =>
      brightness==Brightness.light? const Color(0xFF181817) : const Color(0xFFffffff);

  Color get gold =>
      brightness==Brightness.light? const Color(0xFFD0AE64) : const Color(0xFFD0AE64);

  Color get brownConst =>
      brightness==Brightness.light? const Color(0xFF6D574C) : const Color(0xFF6D574C);

  Color get blackLText =>
      brightness==Brightness.light? const Color(0xFF141413) : const Color(0xffffeeee);

  Color get whiteConst =>
      brightness==Brightness.light? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);

  Color get lightGray =>
      brightness==Brightness.light? const Color(0xFFE5E1DE) : const Color(0xFF030303);

  Color get redLight3 =>
      brightness==Brightness.light? const Color(0xFFF2EEEA) :const Color(0xFF292929) ;

  Color get meshkaItemBorderColor =>
      brightness==Brightness.light? const Color(0x00000000) : const Color(0xFF515050);

  Color get searchAyatRowSoraAyaNumTextBg => brightness == Brightness.light
      ? const Color(0xff4d6ec3)
      : const Color(0xff383838);

  Color get searchAyatRowSoraAyaNumText => brightness == Brightness.light
      ? const Color(0xfffdfdfd)
      : const Color(0xfffdfdfd);



  Color get searchAyatRowSoraDivider => brightness == Brightness.light
      ? const Color(0xffB3B3B3)
      : const Color(0xffB3B3B3);

  Color get blue => brightness == Brightness.light
      ? const Color(0xff4d6ec3)
      : const Color(0xff4d6ec3);

  Color get searchUnselectedTab => brightness == Brightness.light
      ? const Color(0xff666666)
      : const Color(0xff666666);

  Color get white=>
      brightness==Brightness.light? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  Color get white2=>
      brightness==Brightness.light? const Color(0xFFFFFFFF) : const Color(0xFF121212);

  Color get lightGray2 =>
      brightness==Brightness.light? const Color(0xFFf2f2f2) : const Color(0xFF1f1f1f);

  Color get blackWhite =>
      brightness == Brightness.light
          ? const Color(0xff252525)
          : const Color(0xfffdfdfd);

  Color get iconColor =>
      brightness == Brightness.light
      ? const Color(0xff666666)
      : const Color(0xffffffff);

  Color get khatmaBg => brightness == Brightness.light
      ? const Color(0xff394D7F)
      : const Color(0xff121212);
  Color get blackWhite2=>
      brightness==Brightness.light? const Color(0xFF201f1f) : const Color(0xFFd9d9d9);

  Color get grayWhite =>
      brightness == Brightness.light
          ? const Color(0xfffdfdfd)
          : const Color(0xff2B2B2B);

  Color get whiteGray =>
      brightness == Brightness.light
          ? const Color(0xff2B2B2B)
          : const Color(0xfffdfdfd);

  Color get blackBlue =>
      brightness == Brightness.light
          ? const Color(0xff394D7F)
          : const Color(0xFF1f1f1f);
}


