import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohafez/core/extensions/extensions.dart';
import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/theme/dark_mode/cubit/theme_cubit.dart';
import '../../../../utils/Constants.dart';
import '../../domain/quran_util/QuranUtils.dart';
import '../cubit/AyatHighlightCubit.dart';
import '../cubit/QuranPageCubit.dart';

class PageStackWidget extends StatefulWidget {
  final QuranPageCubit quranPageCubit;
  final PageController? controller;
  Quran? aya;

  PageStackWidget({Key? key,required this.quranPageCubit,required this.controller,this.aya }): super(key: key);

  @override
  State<PageStackWidget> createState() => _PageStackWidgetState();
}

class _PageStackWidgetState extends State<PageStackWidget> {
  late AyatHighlightCubit ayatHighlightCubit;
  List<ExportLine> highlightedAyaLines = [];

  @override
  void initState() {
    super.initState();
    ayatHighlightCubit = AyatHighlightCubit.get(context);
    highLightAyaIfExist();
  }

  @override
  Widget build(BuildContext context) {
    final double lineHeight = ((MediaQuery.of(context).size.width * 150) / Constants.PageWidth);

    return BlocBuilder<AyatHighlightCubit, HighlightState>(
        buildWhen: (previousState, currentState) => onHighlightStateChange(currentState),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...List.generate(highlightedAyaLines.length, (index) {
                final lineNumber = index + 1;
                return Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: getQuranPage(highlightedAyaLines[index], ),
                );
              }),
            ],
          );
        });
  }

  Widget getQuranPage(ExportLine line) {
    final rectHighlight = _buildHighlightWidgets(line.LineNum);
    final isPortrait = context.getOrentation() == Orientation.portrait;
    
    return GestureDetector(
      onVerticalDragUpdate: isPortrait ? _handleVerticalDrag : null,
      onLongPressStart: (pos) => {},
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
              _buildAyaLineWithFilter(line.PageNo, line.LineNum),
            ],
          ),
        ),
      ),
    );
  }
  
  List<Widget> _buildHighlightWidgets(int line) {
    if (highlightedAyaLines.isEmpty) return [];

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
    return ayaLine;
  }
  
  void _handleVerticalDrag(DragUpdateDetails details) {
    // const int sensitivity = 8;
    // if (details.delta.dy > sensitivity) {
    //   ThemeCubit.get(context).changeAppThemeNIGHT();
    // } else if (details.delta.dy < -sensitivity) {
    //   ThemeCubit.get(context).changeAppThemeLIGHT();
    // }
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

    highlightedAyaLines = list;
    updateIfMounted();
  }

  void updateIfMounted() {
    if (mounted) {
      setState(() {});
    }
  }

  void openQuranView(Quran aya) {
    goToPage(aya.PageNum - 1);
  }

  void highLightAyaIfExist() {
    if (widget.aya == null) return;

    ayatHighlightCubit
          .getHighlightOfPlayingAya(widget.aya?.SoraNum ?? 0, widget.aya?.AyaNum ?? 0)
          .then((value) => drawHighlight(value, false));
  }

  void goToPage(int page) {
    widget.controller?.jumpToPage(page);
  }

  bool isTablet() {
    return mounted && context.getDeviceType() == DeviceType.Tablet;
  }
}