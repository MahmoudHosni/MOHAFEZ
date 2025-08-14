import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:great_quran/core/entity/quran/QuranPagesInfo.dart';
import 'package:great_quran/core/extensions/extensions.dart';
import 'package:great_quran/core/utils/Constants.dart';
import 'package:great_quran/dark_mode/themes/custom_themedata_ext.dart';
import 'package:great_quran/features/quran_show/domain/quran_util/QuranUtils.dart';
import 'package:great_quran/features/quran_show/presentation/widgets/quran_page_util.dart';
import '../../../../core/utils/fonts_manager.dart';

class PageHeaderView extends StatefulWidget {
  final QuranPagesInfo? pageInfo;
  final Orientation orientation;
  final int soraIndex;

  const PageHeaderView({
    super.key,
    required this.pageInfo,
    required this.orientation,
    required this.soraIndex,
  });

  @override
  State<PageHeaderView> createState() => _PageHeaderViewState();
}

class _PageHeaderViewState extends State<PageHeaderView> {
  // Constants for better maintainability
  static const double _separatorFontSize = 13.0;
  static const double _rubaContainerTopPadding = 6.0;
  static const double _backgroundImageTopPadding = 3.0;
  static const String _separatorText = "|";
  static const String _defaultHezbNum = "1";
  
  // Cache frequently accessed values
  late final bool isPortrait;

  @override
  void initState() {
    super.initState();
    _initializeCachedValues();
  }

  void _initializeCachedValues() {
    isPortrait = widget.orientation == Orientation.portrait;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _getContainerPadding(),
      margin: _getContainerMargin(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildBackgroundImage(),
          _buildHeaderContent(),
        ],
      ),
    );
  }

  EdgeInsets _getContainerPadding() {
    final horizontalPadding = 2.0.toDimansionValue(context);
    return EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 0);
  }

  EdgeInsets _getContainerMargin() {
    final topMargin = context.isPhone ? 10.0 : 4.0;
    final bottomMargin = context.isPhone ? 8.0 : 2.0;
    return EdgeInsets.fromLTRB(0, topMargin, 0, bottomMargin);
  }

  Widget _buildBackgroundImage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, _backgroundImageTopPadding, 0, 0),
      height: _getBackgroundHeight(),
      margin: _getBackgroundMargin(),
      child: Image(
        image: AssetImage(_getBackgroundImagePath()),
        fit: BoxFit.fill,
      ),
    );
  }

  double _getBackgroundHeight() {
    if (context.isPhone) {
      return isPortrait ? 36.0 : 46.0;
    }
    return (context.isTablet && isPortrait) ? 41.0 : 31.0;
  }

  EdgeInsets _getBackgroundMargin() {
    final horizontalMargin = context.isPhone ? 10.0 : 16.0;
    return EdgeInsets.fromLTRB(horizontalMargin, 0, horizontalMargin, 0);
  }

  String _getBackgroundImagePath() {
    return context.isNightMode()
        ? "assets/drawables/soura_name_bg_night.png"
        : "assets/drawables/soura_name_bg.png";
  }

  Widget _buildHeaderContent() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 11.0.toDimansionValue(context)),
          _buildLeftSection(),
          SizedBox(width: 80.0.toValue(context)),
          _buildSoraName(),
          SizedBox(width: 11.0.toDimansionValue(context)),
        ],
      ),
    );
  }

  Widget _buildLeftSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAjzaText(),
        const SizedBox(width: 4),
        _buildSeparator(),
        const SizedBox(width: 4),
        _buildRubaContainer(),
        const SizedBox(width: 2),
        _buildHezbText(),
      ],
    );
  }

  Widget _buildAjzaText() {
    final ajzaName = _getAjzaName();
    return Text(
      ajzaName,
      style: TextStyle(
        fontSize: _getAjzaFontSize(),
        fontFamily: 'AQF_Sura_parts',
        color: Theme.of(context).blackWithGray,
        decoration: TextDecoration.none,
      ),
    );
  }

  String _getAjzaName() {
    if (widget.pageInfo?.PartNum == null) return "";
    final partNum = widget.pageInfo!.PartNum;
    final ajzaNames = QuranUtils.AjzaNames();
    if (partNum > 0 && partNum <= ajzaNames.length) {
      return ajzaNames[partNum - 1];
    }
    return "";
  }

  double _getAjzaFontSize() {
    if (isPortrait) {
      return context.isPhone ? 14.0 : 24.0;
    }
    return context.isPhone ? 22.0 : 18.0;
  }

  Widget _buildSeparator() {
    return Text(
      _separatorText,
      style: TextStyle(
        fontSize: _separatorFontSize,
        fontFamily: Constants.IBM,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).MoshafColor,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget _buildRubaContainer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, _rubaContainerTopPadding, 0, 0),
      child: _buildRubaView(),
    );
  }

  Widget _buildHezbText() {
    final hezbText = _getHezbText();
    return Text(
      hezbText,
      style: TextStyle(
        fontSize: _getHezbFontSize(),
        fontFamily: Fonts.MaimanFont,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).blackWithGray,
        decoration: TextDecoration.none,
      ),
    );
  }

  String _getHezbText() {
    if (widget.pageInfo?.HezbNum == null) {
      return QuranPageUtil.replaceEnglishNumber(_defaultHezbNum);
    }
    return QuranPageUtil.replaceEnglishNumber(widget.pageInfo!.HezbNum.toString());
  }

  double _getHezbFontSize() {
    if (isPortrait) {
      return context.isPhone ? 10.0 : 17.0;
    }
    return context.isPhone ? 13.0 : 9.0;
  }

  Widget _buildSoraName() {
    final soraNames = QuranUtils.SoraNames();
    final soraName = (widget.soraIndex >= 0 && widget.soraIndex < soraNames.length)
        ? soraNames[widget.soraIndex]
        : "";
    
    return Text(
      soraName,
      style: TextStyle(
        fontSize: _getSoraNameFontSize(),
        fontFamily: 'AQF_Sura_parts',
        color: Theme.of(context).blackWithGray,
        decoration: TextDecoration.none,
      ),
    );
  }

  double _getSoraNameFontSize() {
    if (isPortrait) {
      return context.isPhone ? 15.0 : 25.0;
    }
    return context.isPhone ? 25.0 : 19.0;
  }

  Widget _buildRubaView() {
    return SvgPicture.asset(
      QuranUtils.getRubaImage(widget.pageInfo?.RubNum ?? 0),
      width: _getRubaWidth(),
      height: _getRubaHeight(),
      color: context.isNightMode() ? Colors.white70 : Colors.black54,
      fit: BoxFit.fitHeight,
    );
  }

  double _getRubaWidth() {
    if (isPortrait) {
      return context.isPhone ? 30.0 : 34.0;
    }
    return context.isPhone ? 34.0 : 18.0;
  }

  double _getRubaHeight() {
    if (isPortrait) {
      return context.isPhone ? 30.0 : 34.0;
    }
    return context.isPhone ? 34.0 : 28.0;
  }
}