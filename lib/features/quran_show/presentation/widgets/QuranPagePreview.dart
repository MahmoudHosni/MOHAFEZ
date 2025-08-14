import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohafez/core/extensions/extensions.dart';
import 'package:mohafez/core/theme/dark_mode/themes/custom_themedata_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../core/entity/quran/QuranPagesInfo.dart';
import '../../../../core/theme/dark_mode/cubit/theme_cubit.dart';
import '../../../../utils/Constants.dart';
import '../../domain/quran_util/QuranUtils.dart';
import '../cubit/QuranPageCubit.dart';
import '../../../../features/quran_show/presentation/widgets/dynamic_aya_num.dart';
import 'PageHeaderView.dart';
import 'PageNumberView.dart';

class QuranPagePreview extends StatefulWidget {
  final List<AyaNumPositions> ayatPositions;
  final QuranPageCubit quranPageCubit;
  final int pageNo;
  final Orientation orientation;

  const QuranPagePreview(
      {Key? key,
        required this.quranPageCubit,
        required this.ayatPositions,
        required this.pageNo,
        required this.orientation, })
      : super(key: key);

  @override
  State<QuranPagePreview> createState() => _QuranPagePreviewState();
}

class _QuranPagePreviewState extends State<QuranPagePreview> {
  bool darkMode = false;
  double scale = 0.5833333333333334;
  double scaleRatio = 1.505;
  QuranPagesInfo? pageInfo;
  List<CellData> matrixValues = List<CellData>.generate(20, (index) => CellData(0.0, index));

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) =>
          scale = (value.getDouble("Scale")??2)
    );
    SharedPreferences.getInstance().then((value) =>
          scaleRatio = (value.getDouble("ScaleRatio")??2)
    );
    upDateMatrixValues(Constants.predefinedFilters['Invers']!);
    widget.quranPageCubit.getPageInfo(widget.pageNo).then((value) => onGetPageInfo(value));
  }

  @override
  Widget build(BuildContext context) {
    darkMode = context.isNightMode();
    int soraIndex = QuranUtils.getSuraForPageArray()[widget.pageNo - 1] - 1;
    double lineHeight = ((MediaQuery.of(context).size.width * 150) / Constants.PageWidth);
    var linesCount = ( widget.pageNo==1 || widget.pageNo==2 ) ? 17 :15;

    return Container(color: Theme.of(context).white2,margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Column(  crossAxisAlignment: CrossAxisAlignment.stretch,mainAxisSize: MainAxisSize.max,children: [
              PageHeaderView(orientation: widget.orientation,pageInfo: pageInfo,soraIndex: soraIndex),

              const SizedBox(height: 3,),

              for(var i=1; i<= linesCount;i++)
                Flexible(flex: 1,fit: FlexFit.tight,child: getQuranPage(widget.pageNo,i,lineHeight)),

               PageNumberView(pageNo: pageInfo?.PageNum??0,orientation: widget.orientation,callBack: null,),
            ],),
    );
  }

  getQuranPage(int page,int line,double height) {
    if(line<=15) {
      var ayat = widget.ayatPositions.where((element) => element.LineNum == line);

      return GestureDetector(onVerticalDragUpdate: (context.getOrentation() ==
          Orientation.portrait) ? (details) {
        if (context.getOrentation() == Orientation.portrait) {
          int sensitivity = 8;
          if (details.delta.dy > sensitivity) {
            ThemeCubit.get(context).changeAppThemeNIGHT();
          } else if (details.delta.dy < -sensitivity) {
            ThemeCubit.get(context).changeAppThemeLIGHT();
          }
        } else {
          return;
        }
      } : null,
          child:FittedBox(fit: BoxFit.cover, alignment: Alignment.center,
            child: Transform.scale(
                scale: 0.760,
                alignment: Alignment.bottomCenter,
                child: Stack(alignment: Alignment.center, children: [
                  for (final pos in ayat)
                    DynamicAyaNum(
                      ayaPosition: pos,
                      orientation: Orientation.landscape,
                      scale: scale,
                      scaleRatio: scaleRatio,
                    ),

                  context.isNightMode() ?
                        ColorFiltered(colorFilter: ColorFilter.matrix(matrixValues.map<double>((entry) => entry.value).toList()), child: getAyaLine(line, height))
                      : getAyaLine(line, height),
                ],)),
          ),
          onLongPressStart: (pos) {},
          onTapUp: (pos) {
            context.read<NavMainCubit>().hideORShowNavigator(willShow: true);
          });
    }else {
      return const SizedBox();
    }
  }

  getAyaLine(int line,double height) {
    return SizedBox(width: MediaQuery.of(context).size.width,
      child:  Image(
        fit:   BoxFit.cover,alignment: Alignment.center,
        image: AssetImage("${Constants.assetsQuranPagesFolder + ("${widget.pageNo}.$line")}.png"),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  onGetPageInfo(QuranPagesInfo? value) {
    if (value == null) {
      return;
    }
    pageInfo = value;
    updateIfMounted();
  }

  void updateIfMounted() {
    if (mounted) {
      setState(() {});
    }
  }

  void upDateMatrixValues(List<double> values) {
    for (int i = 0; i < values.length; i++) {
      matrixValues[i].value = values[i];
    }
  }
}