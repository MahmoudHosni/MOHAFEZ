import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../core/theme/color_manager.dart';
import 'Constants.dart';

bool isNumber(String? string) {
  // Null or empty string is not a number
  if (string == null || string.isEmpty) {
    return false;
  }
  // Try to parse input string to number.
  // Both integer and double work.
  // Use int.tryParse if you want to check integer only.
  // Use double.tryParse if you want to check double only.
  // final number = num.tryParse(string);
  final number = int.tryParse(string);
  if (number == null) {
    return false;
  }
  return true;
}

String getStringOfSoraNumber(int soraNum) {
  if (soraNum > 99) {
    return soraNum.toString();
  } else if (soraNum > 9) {
    return "0$soraNum";
  }
  return "00$soraNum";
}

String getLinkReaderSora(int readerId, String path, int soraNum) {
  var soraNumText = getStringOfSoraNumber(soraNum);
  return  path +
          soraNumText +
          Platform.pathSeparator +
          soraNumText +
          Constants.extensionMp3;
}

String getLinkOfReaderSora(int readerId, int soraNum) {
  var soraNumText = getStringOfSoraNumber(soraNum);
  return Constants.soundsBaseUrl +
      readerId.toString() +
      Platform.pathSeparator +
      "m" +
      Platform.pathSeparator +
      soraNumText +
      Platform.pathSeparator +
      soraNumText +
      Constants.extensionMp3;
}

String getAppLanguageCode(BuildContext context) {
  Locale activeLocale = Localizations.localeOf(context);
// If our active locale is fr_CA
  return activeLocale.languageCode;
}

bool isArabicLocale(BuildContext context) {
  return getAppLanguageCode(context) == Constants.arabicCode;
}

bool isEnglishLocale(BuildContext context) {
  return getAppLanguageCode(context) == Constants.englishCode;
}

void goBack(BuildContext context) {
  Navigator.pop(context);
}

void showToast(String msg, [Toast? toastLength]) {
  toastLength = toastLength ?? Toast.LENGTH_SHORT;
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.red,
      textColor: ColorManager.white,
      fontSize: 16.0);
}

void showToastBlue(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.BlueDark,
      textColor: ColorManager.white,
      fontSize: 16.0);
}

String replaceArabicNumbers(String input) {
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  for (int i = 0; i < arabic.length; i++) {
    input = input.replaceAll(arabic[i], english[i]);
  }
  return input;
}
