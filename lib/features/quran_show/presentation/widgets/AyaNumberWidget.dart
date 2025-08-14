import 'package:flutter/material.dart';
import 'package:mohafez/core/extensions/extensions.dart';
import 'package:mohafez/core/theme/dark_mode/themes/custom_themedata_ext.dart';
import 'package:mohafez/features/quran_show/presentation/widgets/quran_page_util.dart';

class AyaNumberWidget extends StatelessWidget {
  // Constants for font sizes
  static const double _portraitPhoneFontSize = 8.0;
  static const double _portraitTabletFontSize = 12.0;
  static const double _landscapePhoneFontSize = 16.0;
  static const double _landscapeTabletFontSize = 19.0;
  
  // Asset paths
  static const String _ornamentDayAsset = "assets/lines/aya_ornament.png";
  static const String _ornamentNightAsset = "assets/lines/aya_ornament_night.png";

  final int ayaNum;
  final Orientation orientation;

  const AyaNumberWidget({
    super.key,
    required this.ayaNum,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildOrnamentImage(context),
        _buildAyaNumberText(context),
      ],
    );
  }

  Widget _buildOrnamentImage(BuildContext context) {
    final assetPath = context.isNightMode() 
        ? _ornamentNightAsset 
        : _ornamentDayAsset;
    
    return Image.asset(assetPath);
  }

  Widget _buildAyaNumberText(BuildContext context) {
    final arabicNumber = QuranPageUtil.replaceEnglishNumber(ayaNum.toString());
    
    return Text(
      arabicNumber,
      textAlign: TextAlign.center,
      maxLines: 1,
      style: _getTextStyle(context),
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: _calculateFontSize(context),
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).selectionsHomeLabel,
    );
  }

  double _calculateFontSize(BuildContext context) {
    final isPhone = context.getDeviceType() == DeviceType.Phone;
    
    if (orientation == Orientation.portrait) {
      return isPhone ? _portraitPhoneFontSize : _portraitTabletFontSize;
    } else {
      return isPhone ? _landscapePhoneFontSize : _landscapeTabletFontSize;
    }
  }
}