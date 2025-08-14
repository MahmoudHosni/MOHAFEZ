import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:great_quran/core/extensions/extensions.dart';
import 'package:great_quran/core/utils/fonts_manager.dart';
import 'package:great_quran/dark_mode/themes/custom_themedata_ext.dart';
import '../../../fahres/presentation/widgets/NavigateToPage.dart';

class PageNumberView extends StatelessWidget {
  // Constants for better maintainability
  static const double _containerHeight = 25.0;
  static const double _containerPadding = 1.0;
  static const double _phoneBottomMargin = 12.0;
  static const double _tabletBottomMargin = 4.0;
  static const double _iconHeight = 14.0;
  static const double _portraitSpacing = 4.0;
  static const double _landscapeSpacing = 8.0;
  
  // Font sizes
  static const double _portraitPhoneFontSize = 10.5;
  static const double _portraitTabletFontSize = 14.0;
  static const double _landscapeFontSize = 13.0;
  
  // Dialog dimensions
  static const double _dialogHeight = 580.0;
  static const double _dialogWidth = 450.0;
  
  // Asset paths
  static const String _backgroundNightAsset = "assets/svg/pnumber_night.svg";
  static const String _backgroundDayAsset = "assets/svg/Vector.svg";
  static const String _pageRightIcon = "assets/svg/ic_page_right.svg";
  static const String _pageLeftIcon = "assets/svg/ic_page_left.svg";

  final int pageNo;
  final Orientation orientation;
  final Function? callBack;

  const PageNumberView({
    super.key,
    required this.pageNo,
    required this.orientation,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openPageNavigation(context),
      child: Container(
        height: _containerHeight.toValue(context),
        padding: const EdgeInsets.all(_containerPadding),
        margin: _getContainerMargin(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBackgroundImage(context),
            _buildPageContent(context),
          ],
        ),
      ),
    );
  }

  EdgeInsets _getContainerMargin(BuildContext context) {
    final bottomMargin = context.getDeviceType() == DeviceType.Phone
        ? _phoneBottomMargin
        : _tabletBottomMargin;
    return EdgeInsets.fromLTRB(0, 0, 0, bottomMargin);
  }

  Widget _buildBackgroundImage(BuildContext context) {
    final assetPath = context.isNightMode() 
        ? _backgroundNightAsset 
        : _backgroundDayAsset;
    
    return SvgPicture.asset(
      assetPath,
      fit: BoxFit.contain,
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPageDirectionIcon(context),
        SizedBox(width: _getSpacing()),
        _buildPageNumberText(context),
      ],
    );
  }

  Widget _buildPageDirectionIcon(BuildContext context) {
    final isOddPage = _isOddPage();
    final iconAsset = isOddPage ? _pageRightIcon : _pageLeftIcon;
    
    return SvgPicture.asset(
      iconAsset,
      color: Theme.of(context).MoshafColor,
      height: _iconHeight,
    );
  }

  Widget _buildPageNumberText(BuildContext context) {
    return Text(
      pageNo.toString(),
      style: TextStyle(
        fontSize: _calculateFontSize(context),
        backgroundColor: Colors.transparent,
        fontFamily: Fonts.MaimanFont,
        color: Theme.of(context).blackWithGray,
        decoration: TextDecoration.none,
      ),
    );
  }

  bool _isOddPage() {
    return (pageNo) % 2 != 0;
  }

  double _getSpacing() {
    return orientation == Orientation.portrait 
        ? _portraitSpacing 
        : _landscapeSpacing;
  }

  double _calculateFontSize(BuildContext context) {
    if (orientation == Orientation.portrait) {
      final isPhone = context.getDeviceType() == DeviceType.Phone;
      return isPhone ? _portraitPhoneFontSize : _portraitTabletFontSize;
    } else {
      return _landscapeFontSize;
    }
  }

  void _openPageNavigation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: _dialogHeight,
        width: _dialogWidth,
        child: NavigateToPage(),
      ),
    ).then((value) {
      if (callBack != null && value != null) {
        callBack!(value);
      }
    });
  }
}