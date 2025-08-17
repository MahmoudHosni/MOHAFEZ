import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohafez/core/extensions/extensions.dart';
import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../../../../core/entity/quran/CellData.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/entity/quran/QuranPagesInfo.dart';
import '../../../../core/theme/dark_mode/cubit/theme_cubit.dart';
import '../../../../utils/Constants.dart';
import '../../../player/presentation/cubit/PlayerCubit.dart';
import '../../domain/quran_util/QuranUtils.dart';
import '../cubit/AyatHighlightCubit.dart';
import '../cubit/QuranPageCubit.dart';
import '../../../../features/quran_show/presentation/widgets/dynamic_aya_num.dart';

class PageStackWidget extends StatefulWidget {
  final List<AyaNumPositions> ayatPositions;
  final QuranPageCubit quranPageCubit;
  final int pageNo;
  final Orientation orientation;
  final PageController? controller;
  Quran? aya;
  final List<int> pagesInShow;

  PageStackWidget(
      {Key? key,
      required this.quranPageCubit,
      required this.ayatPositions,
      required this.pageNo,
      required this.orientation,
      required this.controller,required this.pagesInShow,
      this.aya })
      : super(key: key);

  @override
  State<PageStackWidget> createState() => _PageStackWidgetState();
}

class _PageStackWidgetState extends State<PageStackWidget> {
  bool darkMode = false;
  late AyatHighlightCubit ayatHighlightCubit;
  QuranPagesInfo? pageInfo;
  List<ExportLine> highlightedAyaLines = [];
  List<CellData> matrixValues = List<CellData>.generate(20, (index) => CellData(0.0, index));
  late var highlightedLinesWidgets;
  
  // Cache expensive computations
  late final int _soraIndex;
  late final int _linesCount;
  List<double>? _colorMatrix;

  @override
  void initState() {
    super.initState();
    
    // Cache expensive computations once
    _soraIndex = QuranUtils.getSuraForPageArray()[widget.pageNo - 1] - 1;
    _linesCount = (widget.pageNo == 1 || widget.pageNo == 2) ? 17 : 15;
    
    upDateMatrixValues(Constants.predefinedFilters['Invers']!);
    _colorMatrix = matrixValues.map<double>((entry) => entry.value).toList();
    
    ayatHighlightCubit = AyatHighlightCubit.get(context);
    widget.quranPageCubit.getPageInfo(widget.pageNo).then((value) => onGetPageInfo(value));
    
    _initializeHighlighting();
  }
  
  void _initializeHighlighting() {
    if (PlayerCubit.get(context).isPlaying() && ayatHighlightCubit.lastPage == widget.pageNo) {
      Future.delayed(const Duration(milliseconds: 90), () => ayatHighlightCubit.getLatestState());
    } else {
      Future.delayed(const Duration(milliseconds: 90), () => highLightAyaIfExist(widget.aya, widget.pageNo));
    }
  }

  @override
  Widget build(BuildContext context) {
    darkMode = context.isNightMode();
    final double lineHeight = ((MediaQuery.of(context).size.width * 150) / Constants.PageWidth);

    return BlocBuilder<AyatHighlightCubit, HighlightState>(
        buildWhen: (previousState, currentState) => onHighlightStateChange(currentState),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...List.generate(_linesCount, (index) {
                final lineNumber = index + 1;
                return Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: getQuranPage(widget.pageNo, lineNumber, lineHeight),
                );
              }),
            ],
          );
        });
  }

  Widget getQuranPage(int page, int line, double height) {
    if (line > 15) return const SizedBox();
    
    final ayat = widget.ayatPositions.where((element) => element.LineNum == line);
    final rectHighlight = _buildHighlightWidgets(line);
    final isPortrait = context.getOrentation() == Orientation.portrait;
    
    return GestureDetector(
      onVerticalDragUpdate: isPortrait ? _handleVerticalDrag : null,
      onLongPressStart: (pos) => _handleLongPress(pos, line),
      onTapUp: (_) => {},
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.center,
        child: Transform.scale(
          scale: context.getScaleRatio(),
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...rectHighlight,
              ...ayat.map((pos) => DynamicAyaNum(
                ayaPosition: pos,
                orientation: widget.orientation,
                scale: widget.quranPageCubit.scaler,
                scaleRatio: widget.quranPageCubit.scalerRatio,
              )),
              _buildAyaLineWithFilter(page, line),
            ],
          ),
        ),
      ),
    );
  }
  
  List<Widget> _buildHighlightWidgets(int line) {
    if (highlightedAyaLines.isEmpty) return [];
    
    final shouldShowHighlight = isTablet() 
        ? (widget.pageNo ~/ 2 == highlightedAyaLines[0].PageNo ~/ 2)
        : true;
        
    if (!shouldShowHighlight) return [];
    
    final hgLines = highlightedAyaLines.where((element) => element.LineNum == line).toList();
    return QuranUtils.getHighlightedAyatListViews(
      widget.quranPageCubit.scaler,
      widget.quranPageCubit.scalerRatio,
      hgLines,
      context,
    );
  }
  
  Widget _buildAyaLineWithFilter(int pageNo, int line) {
    final ayaLine = getAyaLine(pageNo, line);
    return context.isNightMode()
        ? ColorFiltered(
            colorFilter: ColorFilter.matrix(_colorMatrix ?? []),
            child: ayaLine,
          )
        : ayaLine;
  }
  
  void _handleVerticalDrag(DragUpdateDetails details) {
    const int sensitivity = 8;
    if (details.delta.dy > sensitivity) {
      ThemeCubit.get(context).changeAppThemeNIGHT();
    } else if (details.delta.dy < -sensitivity) {
      ThemeCubit.get(context).changeAppThemeLIGHT();
    }
  }
  
  void _handleLongPress(LongPressStartDetails pos, int line) {
    onSelectPosition(
      TapDownDetails(
        globalPosition: pos.globalPosition,
        localPosition: pos.localPosition,
      ),
      widget.quranPageCubit.scaler * widget.quranPageCubit.scalerRatio,
      widget.pageNo,
      widget.orientation,
      line,
    );
  }

  Widget getAyaLine(int pageNo, int line) {
    return SizedBox(
      width:  MediaQuery.of(context).size.width,
      child: Image.asset(
        "${Constants.assetsQuranPagesFolder}$pageNo.$line.png",
        fit: BoxFit.cover,
        alignment: Alignment.center,
        width:  MediaQuery.of(context).size.width,
      ),
    );
  }

  void onSelectPosition(TapDownDetails pos, double scale, int page, Orientation orientation,int line,) {
    ayatHighlightCubit
        .getHighlightOfSelectedAya(pos, scale, page, orientation,line,)
        .then((value) => drawHighlight(value, true));
  }

  bool onHighlightStateChange(HighlightState state) {
    if (state is PlayHighlightState || state is SearchHighlightState) {
      _handleHighlightState();
    }
    return state is PlayHighlightState;
  }
  
  void _handleHighlightState() {
    final playerStatus = ayatHighlightCubit.playerHighlightStatus;
    ayatHighlightCubit
        .getHighlightOfPlayingAya(playerStatus.soraNum, playerStatus.ayaNum)
        .then((value) {
      if (mounted) {
        Future.delayed(
          const Duration(milliseconds: 10),
          () => drawHighlight(value, false),
        );
      }
    });
  }

  void drawHighlight(List<ExportLine> list, bool openPlayer) {
    if (list.isEmpty) return;
    
    final firstLine = list[0];
    ayatHighlightCubit.updateLatesthighlightedAya(
      firstLine.SoraID,
      firstLine.AyaNum,
      firstLine.PageNo,
    );
    
    if (openPlayer && firstLine.AyaNum > 0) {

    } else {
      _handlePageNavigation(firstLine);
    }
    
    if (widget.pageNo == firstLine.PageNo) {
      highlightedAyaLines = list;
    }
    updateIfMounted();
  }
  
  void _handlePageNavigation(ExportLine line) {
    if (line.AyaNum <= 0) return;
    
    if (isTablet()) {
      if (!widget.pagesInShow.contains(widget.pageNo)) {
        final isEven = line.PageNo % 2 == 0;
        final targetPage = isEven ? (line.PageNo ~/ 2 - 1) : (line.PageNo ~/ 2);
        widget.controller?.jumpToPage(targetPage);
        if (isEven) widget.aya = null;
      }
    } else {
      if (widget.pageNo != line.PageNo) {
        goToPage(line.PageNo - 1);
      }
    }
  }

  void onGetPageInfo(QuranPagesInfo? value) {
    if (value == null) return;
    pageInfo = value;
    updateIfMounted();
  }

  void updateIfMounted() {
    if (mounted) {
      setState(() {});
    }
  }

  void upDateMatrixValues(List<double> values) {
    for (int i = 0; i < values.length && i < matrixValues.length; i++) {
      matrixValues[i].value = values[i];
    }
    // Update cached matrix
    _colorMatrix = matrixValues.map<double>((entry) => entry.value).toList();
  }

  void openQuranView(Quran aya) {
    goToPage(aya.PageNum - 1);
  }

  void highLightAyaIfExist(Quran? aya, int pageNo) {
    if (aya == null) return;
    
    final shouldHighlight = isTablet()
        ? ((pageNo ~/ 2) == ((aya.PageNum ?? 0) ~/ 2))
        : (aya.PageNum == pageNo);
    
    if (shouldHighlight) {
      ayatHighlightCubit
          .getHighlightOfPlayingAya(aya.SoraNum ?? 0, aya.AyaNum ?? 0)
          .then((value) => drawHighlight(value, false));
    }
  }

  void goToPage(int page) {
    final targetPage = widget.pagesInShow.length > 1 ? (page ~/ 2) : page;
    widget.controller?.jumpToPage(targetPage);
  }

  Widget getEmptyLine() {
    return context.getDeviceType() == DeviceType.Phone
        ? const SizedBox(height: 13.0)
        : const SizedBox();
  }

  bool isTablet() {
    return mounted && context.getDeviceType() == DeviceType.Tablet;
  }
}