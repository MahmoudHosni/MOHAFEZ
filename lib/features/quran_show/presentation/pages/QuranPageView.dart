import 'package:flutter/material.dart';
import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../utils/Constants.dart';
import '../cubit/QuranPageCubit.dart';
import '../widgets/PageStackWidget.dart';
import 'package:nb_utils/nb_utils.dart';

class QuranPageView extends StatefulWidget {
  final int pageNo;
  final QuranPageCubit quranPageCubit;
  final Orientation orientation;
  final PageController controller;
  final Quran? aya;

  const QuranPageView({
    super.key,
    required this.pageNo,
    required this.quranPageCubit,
    required this.orientation,
    required this.controller,
    this.aya,
  });

  @override
  State<QuranPageView> createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  List<AyaNumPositions> _ayatPositions = [];
  List<AyaNumPositions> _ayatPositionsSecondPage = [];
  int _currentPage = 0;
  
  // Cached values for performance
  late DeviceType _deviceType;
  late bool _isTablet;
  late bool _isPhone;
  late bool _isDoublePages;
  late MediaQueryData _mediaQuery;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeCachedValues();
  }

  void _initializeCachedValues() {
    _deviceType = context.getDeviceType();
    _isTablet = context.isTablet();
    _isPhone = context.isPhone();
    _isDoublePages = context.isDoublePages();
    _mediaQuery = MediaQuery.of(context);
  }

  @override
  Widget build(BuildContext context) {
    _initializeCachedValues();
    
    return LayoutBuilder(
      key: ValueKey('${widget.pageNo}_${widget.orientation}'),
      builder: (context, constraints) {
        _initializeScaleIfNeeded(constraints);
        return _buildContent(constraints);
      },
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    if (widget.orientation == Orientation.portrait) {
      return _buildSinglePageView();
    }
    
    return _buildLandscapeContent(constraints);
  }

  Widget _buildLandscapeContent(BoxConstraints constraints) {
    if (_isPhone || (_isTablet && !_isDoublePages)) {
      return _buildScrollableQuranPage(constraints);
    }
    
    return _buildDoublePageView();
  }

  Widget _buildSinglePageView() {
    _loadAyatPositions(widget.pageNo);
    return PageStackWidget(
      key: ValueKey(widget.pageNo),
      quranPageCubit: widget.quranPageCubit,
      ayatPositions: _ayatPositions,
      pageNo: widget.pageNo,
      orientation: widget.orientation,
      controller: widget.controller,
      aya: widget.aya,
      pagesInShow: [_currentPage],
    );
  }

  Widget _buildScrollableQuranPage(BoxConstraints constraints) {
    final height = _deviceType == DeviceType.Phone
        ? constraints.maxHeight * 3.75
        : constraints.maxHeight * 2.8;

    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        width: constraints.maxWidth,
        child: _buildSinglePageView(),
      ),
    );
  }

  Widget _buildDoublePageView() {
    if (widget.orientation == Orientation.landscape && _isTablet) {
      _currentPage = (widget.pageNo * 2) - 1;
    }
    
    _loadAyatPositions(_currentPage);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: PageStackWidget(
            quranPageCubit: widget.quranPageCubit,
            ayatPositions: _ayatPositions,
            pageNo: _currentPage,
            orientation: widget.orientation,
            controller: widget.controller,
            aya: widget.aya,
            pagesInShow: [_currentPage, _currentPage + 1],
          ),
        ),
        _buildPageDivider(),
        Expanded(
          child: PageStackWidget(
            quranPageCubit: widget.quranPageCubit,
            ayatPositions: _ayatPositionsSecondPage,
            pageNo: _currentPage + 1,
            orientation: widget.orientation,
            controller: widget.controller,
            aya: widget.aya,
            pagesInShow: [_currentPage, _currentPage + 1],
          ),
        ),
      ],
    );
  }

  Widget _buildPageDivider() {
    return Container(
      height: _mediaQuery.size.height,
      width: 0.35,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38),
        ],
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

  void _loadAyatPositions(int pageNo) {
    widget.quranPageCubit
        .getAyatPositionsInPage(pageNo)
        .then(_handleAyatPositionsLoaded);
  }

  void _handleAyatPositionsLoaded(List<AyaNumPositions> positions) {
    if (!mounted) return;
    
    _ayatPositions = positions;
    
    if (_shouldLoadSecondPage()) {
      _loadSecondPagePositions();
    } else {
      _updateStateIfMounted();
    }
  }

  bool _shouldLoadSecondPage() {
    return widget.orientation == Orientation.landscape && 
           _isTablet && 
           _isDoublePages;
  }

  void _loadSecondPagePositions() {
    widget.quranPageCubit
        .getAyatPositionsInPage(_currentPage + 1)
        .then(_handleSecondPagePositionsLoaded);
  }

  void _handleSecondPagePositionsLoaded(List<AyaNumPositions> positions) {
    if (!mounted) return;
    
    _ayatPositionsSecondPage = positions;
    _updateStateIfMounted();
  }

  void _updateStateIfMounted() {
    if (mounted) {
      setState(() {});
    }
  }
}