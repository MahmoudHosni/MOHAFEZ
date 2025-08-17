import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohafez/core/theme/dark_mode/themes/custom_themedata_ext.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/extensions/extensions.dart';
import '../cubit/QuranPageCubit.dart';
import 'QuranPageView.dart';

class QuranPageViewer extends StatefulWidget {
  Quran? aya;

  QuranPageViewer({super.key, this.aya});

  @override
  State<QuranPageViewer> createState() => QuranPageViewerState();
}

class QuranPageViewerState extends State<QuranPageViewer> with WidgetsBindingObserver {
  // Constants
  static const int _totalPagesPhone = 604;
  static const int _totalPagesTabletLandscape = 302;
  late QuranPageCubit quranPageCubit;
  late PageController pageController;

  @override
  void initState() {
    quranPageCubit = QuranPageCubit.get(context);
    super.initState();
    _initializePageController();
    _setupListeners();
    _configureSystemSettings();
  }

  void _setupListeners() {
    WidgetsBinding.instance.addObserver(this);
  }

  void _configureSystemSettings() {
    WakelockPlus.enable();
  }

  void _onNavigationVisibilityChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pageController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _resetPageViewDimensions();
    _configureSystemUI();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {});
    }
    super.didChangeAppLifecycleState(state);
  }

  void _resetPageViewDimensions() {
    quranPageCubit.pageViewHeight = 0;
    quranPageCubit.pageViewWidth = 0;
    quranPageCubit.scale = 0;
  }

  void _configureSystemUI() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual, 
      overlays: [SystemUiOverlay.bottom]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _buildMainContainer(),
      ],
    );
  }

  Widget _buildMainContainer() {
    return Container(
      margin: EdgeInsets.zero,
      color: Theme.of(context).MoshafBG2,
      child: OrientationBuilder(
        builder: (context, orientation) {
          _handleOrientationChange(orientation);
          return _buildPageView(orientation);
        },
      ),
    );
  }

  void _handleOrientationChange(Orientation orientation) {
    _resetPageViewDimensions();
    _configureSystemUI();
    
    if (context.isTablet()) {
      _setTabletOrientation();
    }
  }

  void _setTabletOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Widget _buildPageView(Orientation orientation) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      itemBuilder: (context, position) => _buildPageItem(position, orientation),
      onPageChanged: (pos) => _handlePageChanged(pos, orientation),
      itemCount: _getItemCount(orientation),
      pageSnapping: true,
      padEnds: false,
      reverse: quranPageCubit.isRightToLeft(),
      dragStartBehavior: DragStartBehavior.down,
      controller: pageController,
      allowImplicitScrolling: false,
    );
  }

  Widget _buildPageItem(int position, Orientation orientation) {
    return QuranPageView(
      pageNo: position + 1,
      quranPageCubit: quranPageCubit,
      orientation: orientation,
      controller: pageController,
      aya: widget.aya,
    );
  }

  void _handlePageChanged(int pos, Orientation orientation) {
    _saveCurrentPage(pos, orientation);
  }

  void _saveCurrentPage(int pos, Orientation orientation) {
    final pageToSave = (orientation == Orientation.landscape && context.isTablet())
        ? (pos * 2) + 1 
        : pos;
    quranPageCubit.savePage(pageToSave);
  }

  int _getItemCount(Orientation orientation) {
    if (context.isPhone()) return _totalPagesPhone;
    if (context.isTablet() && orientation == Orientation.portrait) return _totalPagesPhone;
    return _totalPagesTabletLandscape;
  }

  void onSelectReadKhatma(int page, int ayaNo, int soraNo) {
    if (!mounted) return;
    
    setState(() {
      widget.aya = Quran(0, page, "", "", ayaNo, 0, "", 0, "", "", soraNo, "");
    });
    
    final targetPage = page - 1;
    if (targetPage >= 0 && targetPage < _getItemCount(MediaQuery.of(context).orientation)) {
      pageController.jumpToPage(targetPage);
    }
  }

  void _initializePageController() {
    final initialPage = _calculateInitialPage();
    
    pageController = PageController(
      initialPage: initialPage,
      keepPage: true,
      viewportFraction: 1.0,
    );
  }

  int _calculateInitialPage() {
    int page = widget.aya?.PageNum != null 
        ? (widget.aya!.PageNum - 1) 
        : quranPageCubit.getLatestPage();
    
    // Adjust for tablet landscape mode
    if (context.getDeviceType() == DeviceType.Tablet) {
      page = (page / 2).floor();
    }
    
    return page.clamp(0, _totalPagesPhone - 1);
  }
}