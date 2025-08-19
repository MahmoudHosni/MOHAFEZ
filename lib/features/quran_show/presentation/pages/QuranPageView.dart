import 'package:flutter/material.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../utils/Constants.dart';
import '../cubit/QuranPageCubit.dart';
import '../widgets/PageStackWidget.dart';

class QuranPageView extends StatefulWidget {
  final QuranPageCubit quranPageCubit;
  final Orientation orientation;
  final PageController controller;
  final Quran? aya;

  const QuranPageView({
    super.key,
    required this.quranPageCubit,
    required this.orientation,
    required this.controller,
    this.aya,
  });

  @override
  State<QuranPageView> createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
    // Cached values for performance
  late DeviceType _deviceType;
  late MediaQueryData _mediaQuery;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeCachedValues();
  }

  void _initializeCachedValues() {
    _deviceType = context.getDeviceType();
    _mediaQuery = MediaQuery.of(context);
  }

  @override
  Widget build(BuildContext context) {
    _initializeCachedValues();
    
    return LayoutBuilder(
      key: ValueKey('${widget.aya?.ID}_${widget.orientation}'),
      builder: (context, constraints) {
        _initializeScaleIfNeeded(constraints);
        return _buildContent(constraints);
      },
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
      return _buildScrollableQuranPage(constraints);
  }

  Widget _buildSinglePageView() {
    return PageStackWidget(
      key: ValueKey(widget.aya?.ID ??0),
      quranPageCubit: widget.quranPageCubit,
      orientation: widget.orientation,
      controller: widget.controller,
      aya: widget.aya,
    );
  }

  Widget _buildScrollableQuranPage(BoxConstraints constraints) {
    return SingleChildScrollView(
      child: SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: _buildSinglePageView(),
      ),
    );
  }

  void _initializeScaleIfNeeded(BoxConstraints constraints) {
    if (widget.quranPageCubit.pageViewWidth == 0 && 
        widget.quranPageCubit.pageViewHeight == 0) {
      _calculateScale(constraints);
    }
  }

  void _calculateScale(BoxConstraints constraints) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      final height = _mediaQuery.size.height * 3.3;
      final width = _getWidthConstant();
      
      final quranImageHeight = _calculateQuranImageHeight(height);
      final quranImageWidth = _calculateQuranImageWidth(width);
      
      final scaleRatio = _calculateScaleRatio();
      final scale = _calculateScaleByWidth();
      
      _updateCubitScale(scaleRatio, scale, quranImageWidth, quranImageHeight, width, height);
    });
  }

  double _getWidthConstant() {
    return _deviceType == DeviceType.Phone
        ? Constants.borderThicknessWidth
        : Constants.borderThicknessWidthTablet;
  }

  double _calculateQuranImageHeight(double height) {
    final adjustment = _deviceType == DeviceType.Phone ? 0 : 20;
    return Constants.PageHeight - height + adjustment;
  }

  double _calculateQuranImageWidth(double width) {
    final adjustment = _deviceType == DeviceType.Phone ? 0 : 25;
    return Constants.PageWidth - width + adjustment;
  }

  double _calculateScaleRatio() {
    final physicalWidth = View.of(context).physicalSize.width;
    final logicalWidth = _mediaQuery.size.width;
    return (physicalWidth / logicalWidth) + 0.005;
  }

  double _calculateScaleByWidth() {
    final physicalWidth = View.of(context).physicalSize.width;
    return 1120 / physicalWidth;
  }

  void _updateCubitScale(
    double scaleRatio,
    double scale,
    double quranImageWidth,
    double quranImageHeight,
    double width,
    double height,
  ) {
    final cubit = widget.quranPageCubit;
    cubit.scaleRatio = scaleRatio;
    cubit.scale = scale;
    cubit.pageViewWidth = cubit.scaler * (quranImageWidth + 0.91 * width);
    cubit.pageViewHeight = cubit.scaler * (quranImageHeight + 0.91 * height);
  }
}