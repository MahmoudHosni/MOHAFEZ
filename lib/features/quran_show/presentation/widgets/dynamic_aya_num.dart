import 'package:flutter/material.dart';
import 'package:great_quran/core/entity/aya_position/AyaNumPosition.dart';
import 'package:great_quran/core/extensions/extensions.dart';
import 'package:great_quran/features/quran_show/presentation/widgets/AyaNumberWidget.dart';
import '../../../../core/utils/Constants.dart';

class DynamicAyaNum extends StatelessWidget {
  final Orientation orientation;
  final AyaNumPositions ayaPosition;
  final double scale;
  final double scaleRatio;

  const DynamicAyaNum({
    super.key,
    required this.ayaPosition,
    required this.orientation,
    required this.scale,
    required this.scaleRatio,
  });

  @override
  Widget build(BuildContext context) {
    return ayaPosition.AyaNum == 0 
        ? _buildSoraHeader(context)
        : _buildAyaNumber(context);
  }

  Widget _buildSoraHeader(BuildContext context) {
    final aspectRatio = View.of(context).physicalSize.aspectRatio;
    final horizontalPosition = Constants.defaultAspectRatioMultiplier * aspectRatio;
    
    return Positioned(
      left: horizontalPosition,
      right: horizontalPosition,
      child: _buildSoraHeaderImage(context),
    );
  }

  Widget _buildAyaNumber(BuildContext context) {
    final leftPos = _calculateLeftPosition(context);
    
    return orientation == Orientation.portrait
        ? _buildPortraitAyaNumber(context, leftPos)
        : _buildLandscapeAyaNumber(context, leftPos);
  }

  double _calculateLeftPosition(BuildContext context) {
    final basePosition = ((ayaPosition.X?.toDouble() ?? 0) / scale) / scaleRatio;
    final pageAdjustment = _isEarlyPage() 
        ? Constants.leftPosAdjustment.toLeftPos2Value(context, orientation)
        : 0.0;
    
    return basePosition + pageAdjustment;
  }

  Widget _buildPortraitAyaNumber(BuildContext context, double leftPos) {
    return Positioned(
      top: _calculateTopPosition() + Constants.portraitTopOffset,
      left: leftPos + Constants.leftValueAdjustment.toValue3(context),
      child: _buildAyaContainer(
        context: context,
        width: _getPortraitWidth(context),
        height: _getPortraitHeight(context),
      ),
    );
  }

  Widget _buildLandscapeAyaNumber(BuildContext context, double leftPos) {
    return Positioned(
      top: _calculateTopPosition() + Constants.landscapeTopOffset,
      left: leftPos + Constants.leftValueAdjustment.toValue3Landscape(context),
      child: _buildAyaContainer(
        context: context,
        width: _getLandscapeWidth(context),
        height: _getLandscapeHeight(context),
      ),
    );
  }

  Widget _buildAyaContainer({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(1, 3, 0, 0),
      width: width,
      height: height,
      child: AyaNumberWidget(
        ayaNum: ayaPosition.AyaNum,
        orientation: orientation,
      ),
    );
  }

  double _calculateTopPosition() {
    return ((ayaPosition.Y?.toDouble() ?? 0) / scale) / scaleRatio;
  }

  bool _isEarlyPage() {
    return ayaPosition.PageNo <= Constants.specialPageThreshold;
  }

  double _getPortraitWidth(BuildContext context) {
    final baseWidth = _isEarlyPage() ? Constants.portraitWidthEarly : Constants.portraitWidthRegular;
    return baseWidth.toDimansionValue(context);
  }

  double _getPortraitHeight(BuildContext context) {
    final baseHeight = _isEarlyPage() ? Constants.portraitHeightEarly : Constants.portraitHeightRegular;
    return baseHeight.toDimansionValue(context);
  }

  double _getLandscapeWidth(BuildContext context) {
    final baseWidth = _isEarlyPage() ? Constants.landscapeWidthEarly : Constants.landscapeWidthRegular;
    return baseWidth.toDimansionValueLandscape(context) * Constants.landscapeMultiplier;
  }

  double _getLandscapeHeight(BuildContext context) {
    final baseHeight = _isEarlyPage() ? Constants.landscapeHeightEarly : Constants.landscapeHeightRegular;
    return baseHeight.toDimansionValueLandscape(context) * Constants.landscapeMultiplier;
  }

  Widget _buildSoraHeaderImage(BuildContext context) {
    final soraPath = _getSoraHeaderImagePath(context);
    final aspectRatio = View.of(context).physicalSize.aspectRatio;
    
    return Image(
      alignment: Alignment.center,
      width: _calculateSoraHeaderWidth(aspectRatio),
      height: _calculateSoraHeaderHeight(aspectRatio),
      fit: BoxFit.scaleDown,
      image: AssetImage(soraPath),
    );
  }

  String _getSoraHeaderImagePath(BuildContext context) {
    return context.isNightMode()
        ? "assets/lines/soura_header_night.png"
        : "assets/lines/soura_header.png";
  }

  double _calculateSoraHeaderWidth(double aspectRatio) {
    final baseWidth = (aspectRatio + Constants.aspectRatioOffset) *
        ((ayaPosition.XMax?.toDouble() ?? 0) - (ayaPosition.X?.toDouble() ?? 0));
    return baseWidth - Constants.soraHeaderSizeReduction;
  }

  double _calculateSoraHeaderHeight(double aspectRatio) {
    final baseHeight = (aspectRatio + Constants.aspectRatioOffset) *
        ((ayaPosition.YMax?.toDouble() ?? 0) - (ayaPosition.Y?.toDouble() ?? 0));
    return baseHeight - Constants.soraHeaderSizeReduction;
  }
}