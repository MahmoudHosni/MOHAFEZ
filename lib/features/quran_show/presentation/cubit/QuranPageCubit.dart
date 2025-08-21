import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/entity/aya_position/AyaNumPosition.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../../../core/entity/quran/QuranPagesInfo.dart';
import '../../../fahres/domain/use_cases/GetFirstAyaInPageUsecase.dart';
import '../../domain/use_case/GetAyatOfSora.dart';
import '../../domain/use_case/GetAyatPositionsInPage.dart';
import '../../../../features/quran_show/domain/use_case/GetAyatPositionsInRange.dart';
import '../../../../features/quran_show/presentation/cubit/QuranState.dart';
import '../../domain/use_case/GetLastPageOpenedUsecase.dart';
import '../../domain/use_case/GetPageInfo.dart';
import '../../domain/use_case/IsPagesRight.dart';
import '../../domain/use_case/SavePageUsecase.dart';

class QuranPageCubit extends Cubit<QuranState>{
  double _scale = 1;
  double get scaler=> _scale;
  set scale(double scNew){
    _scale = scNew;
    SharedPreferences.getInstance().then((value) => value.setDouble("Scale", scNew));
  }

  double _scaleRatio = 1;
  double get scalerRatio=> _scaleRatio;
  set scaleRatio(double scNew){
    _scaleRatio = scNew;
    SharedPreferences.getInstance().then((value) => value.setDouble("ScaleRatio", scNew));
  }

  double pageViewWidth = 0;
  double pageViewHeight = 0;
  final GetAyatOfSora getAyatOfSora;
  final GetAyatPositionsInPage ayatPositionUsecase;
  final GetAyatPositionsInRange ayatPositionsInRange;
  final GetPageInfo pageInfo;
  final IsPagesRight isPagesRight;
  final SavePageUsecase savePageUsecase;
  final GetLastPageOpenedUsecase getLastPageOpenedUsecase;
  final GetFirstAyaInPageUsecase getFirstAyaInPageUsecase;

  QuranPageCubit({required this.ayatPositionUsecase,required this.ayatPositionsInRange ,required this.pageInfo,required this.isPagesRight,
    required this.savePageUsecase,required this.getLastPageOpenedUsecase,required this.getFirstAyaInPageUsecase,required this.getAyatOfSora}) : super(QuranInitial());

  static QuranPageCubit get(context)=>BlocProvider.of(context);

  Future<List<AyaNumPositions>> getAyatPositionsInPage(int page){
    return ayatPositionUsecase.call(page);
  }

  Future<List<AyaNumPositions>> getAyatPositionsInRange(int start,int end){
    return ayatPositionsInRange.call(start,end);
  }

  Future<QuranPagesInfo?> getPageInfo(int pageNo) {
     return pageInfo.call(pageNo);
  }

  bool isRightToLeft() {
    return isPagesRight.call();
  }

  void savePage(int pos) {
    savePageUsecase.call(pos);
  }

  int getLatestPage() {
    return getLastPageOpenedUsecase.call();
  }

  Future<List<Quran?>> getFirstAyaInPage(int page){
    return getFirstAyaInPageUsecase.call(page);
  }

  Future<List<Quran?>> getAyaInSora(int soraId, int start,int end) {
    return getAyatOfSora.call(soraId, start,end);
  }
}