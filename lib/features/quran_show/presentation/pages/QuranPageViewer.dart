import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohafez/core/entity/quran/Quran.dart';
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
  late List<Quran?> ayat;

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
    return Container(
      margin: EdgeInsets.zero,
      color: Colors.yellow,
      child: FutureBuilder(
        future: quranPageCubit.getAyaInSora(1, 1, 7),
        builder: (context,snapshot){
          if(snapshot.hasData) {
            ayat = snapshot.data ?? [];
            return _buildPageView();
          }else{
            return SizedBox();
          }
      }),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      itemBuilder: (context, position) => _buildPageItem(position,),
      onPageChanged: (pos) => {},
      itemCount: _getItemCount(),
      pageSnapping: true,
      padEnds: false,
      reverse: quranPageCubit.isRightToLeft(),
      dragStartBehavior: DragStartBehavior.down,
      controller: pageController,
      allowImplicitScrolling: false,
    );
  }

  Widget _buildPageItem(int position,) {
    return QuranPageView(
      quranPageCubit: quranPageCubit,
      controller: pageController,
      aya: ayat.length>0? ayat[position]:null,
    );
  }

  int _getItemCount() {
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