import 'package:flutter/material.dart';
import 'color_manager.dart';

extension CustomColorsThemeExtensions on ThemeData {
  bool get _isLightTheme => brightness == Brightness.light;

  Color get whiteConst => Colors.white;
  Color get blackConst => Colors.black;
  Color get primaryConst => ColorManager.primary;
  Color get lightWhiteConst => const Color(0xffF2F2F2);

  Color get darkPrimaryConst => const Color(0xff24345D);

  Color get darkPrimaryConst1 => const Color(0xff30467D);
  Color get primaryConst1 => const Color(0xff4C6DC2);

  Color get bgColor =>
      _isLightTheme ? const Color(0xFFFFFFFF) : const Color(0xFF121212);

  Color get black1 =>
      _isLightTheme ? const Color(0xff262626) : const Color(0xffD9D9D9);

  Color get darkBlue =>
      _isLightTheme ? const Color(0xff394D7F) : const Color(0xff394D7F);

  Color get darkBlue1 =>
      _isLightTheme ? const Color(0xff394D7F) : const Color(0xff394D7F);

  Color get darkGray =>
      _isLightTheme ? const Color(0xffBFBFBF) : const Color(0xff4D4D4D);

  Color get darkGray1 =>
      _isLightTheme ? const Color(0xffDDDDDD) : const Color(0xff4D4D4D);

  Color get black2 =>
      _isLightTheme ? const Color(0xffF2F2F2) : const Color(0xff1F1F1F) ;

  Color get lightGray =>
      _isLightTheme ? const Color(0xff666666) : const Color(0xffFFFFFF);


  Color get bodyColor1 =>
      _isLightTheme ? const Color(0xff808080) : const Color(0xff808080);

  Color get bodyColorConst1 => const Color(0xffFDFDFD);
  Color get tabBarDividerColorConst => const Color(0xffB8B8B8);

  Color get separator =>
      _isLightTheme ? const Color(0xffB3B3B3) : const Color(0xffD9D9D9);
  Color get cardBg =>
      _isLightTheme ? const Color(0xffF2F2F2) : const Color(0xff1F1F1F);
  Color get cardBg1 => _isLightTheme ? darkBlue : const Color(0xff383838);
  Color get cardBg2 => _isLightTheme ? primaryConst : const Color(0xff383838);

  Color get cardTextColor =>
      _isLightTheme ? const Color(0xFF121212) : const Color(0xffFFFFFF);

}
