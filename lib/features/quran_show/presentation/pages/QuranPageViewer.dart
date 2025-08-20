import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohafez/core/entity/quran/Sora.dart';
import 'package:mohafez/core/theme/dark_mode/themes/custom_themedata_ext.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../cubit/QuranPageCubit.dart';
import 'QuranPageView.dart';

class QuranPageViewer extends StatefulWidget {
  Sora? sora;

  QuranPageViewer({super.key, this.sora});

  @override
  State<QuranPageViewer> createState() => QuranPageViewerState();
}

class QuranPageViewerState extends State<QuranPageViewer> with WidgetsBindingObserver {
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
  }

  Widget _buildPageView(Orientation orientation) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      itemBuilder: (context, position) => _buildPageItem(position, orientation),
      onPageChanged: (pos) => {},
      itemCount: _getItemCount(orientation),
      pageSnapping: true,
      padEnds: false,
      reverse: quranPageCubit.isRightToLeft(),
      dragStartBehavior: DragStartBehavior.down,
      controller: pageController,
      allowImplicitScrolling: false,
    );
  }

  _buildPageItem(int position, Orientation orientation) async{
   var aya = await quranPageCubit.getAyaInSora(widget.sora!.Id,position);
    return QuranPageView(
      quranPageCubit: quranPageCubit,
      orientation: orientation,
      controller: pageController,
      aya: aya,
    );
  }

  int _getItemCount(Orientation orientation) {
    return widget.sora?.AyatCount ??3;
  }

  void _initializePageController() {
    final initialPage = 0;
    
    pageController = PageController(
      initialPage: initialPage,
      keepPage: true,
      viewportFraction: 1.0,
    );
  }
}