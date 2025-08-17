import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../../../../features/quran_show/domain/use_case/GetRectsFromTouchEvent.dart';
import '../../../player/presentation/cubit/HighlightStatus.dart';
import '../../../player/presentation/cubit/PlayerHighlightStatus.dart';
import '../../domain/use_case/GetRectsOfAya.dart';

part 'HighlightState.dart';

class AyatHighlightCubit extends Cubit<HighlightState>{
  GetRectsFromTouchEvent rectsFromTouchEvent;
  GetRectsOfAya playingAyaRectangles;
  HighlightStatus highlightStatus = HighlightStatus() ;
  PlayerHighlightStatus playerHighlightStatus = PlayerHighlightStatus() ;
  int lastSoraID = 1;
  int lastAyaNum = 1 ;
  int lastPage = 1;

  AyatHighlightCubit({required this.rectsFromTouchEvent,required this.playingAyaRectangles}):super(NormalHighlightState());

  static AyatHighlightCubit get(context)=>BlocProvider.of(context);

  Future<List<ExportLine>> getHighlightOfSelectedAya(TapDownDetails pos, double scale,int page,Orientation orientation,int line){
    return rectsFromTouchEvent.call(pos,scale,page,orientation,line);
  }

  Future<List<ExportLine>> getHighlightOfPlayingAya(int sora,int aya){
    return playingAyaRectangles.call(aya, sora);
  }

  Future<List<ExportLine>> highlightOfAya(int sora,int aya,int page){
    playerHighlightStatus.ayaNum = aya;
    playerHighlightStatus.soraNum = sora;
    emit(SearchHighlightState());
    return playingAyaRectangles.call(aya, sora);
  }

  Future<List<ExportLine>> getLatestState() async{
    if(lastSoraID>0 && lastAyaNum>0) {
      emit(PlayHighlightState());
      lastPage = 0;
      return getHighlightOfPlayingAya(lastSoraID, lastAyaNum);
    }
    return Future.value([]);
  }

  void updateLatesthighlightedAya(int soraID, int ayaNum,int page) {
    lastSoraID =  soraID;
    lastAyaNum = ayaNum;
    lastPage = page;
  }

  toggleHighlight( HighlightStatus highlightStatus,
      int soraNum, int ayaNum) {
    final HighlightStatus copyOfHighlightStatus = HighlightStatus.clone(highlightStatus);
    if (isAyaHighlighted(copyOfHighlightStatus,soraNum, ayaNum)) {
      unHighlightAya(copyOfHighlightStatus,soraNum,ayaNum);
    } else {
      highlightAya(copyOfHighlightStatus,soraNum,ayaNum);
    }
  }

  bool isAyaHighlighted( HighlightStatus highlightStatus,
      int soraNum, int ayaNum) {
    highlightStatus.soraNum = soraNum;
    return ayaNum >= highlightStatus.fromHighLightedAyaNum &&
        ayaNum <= highlightStatus.toHighLightedAyaNum;
  }

  highlightAya( HighlightStatus highlightStatus,
      int soraNum, int ayaNum  ) {
    highlightStatus.soraNum = soraNum;
    if (highlightStatus.toHighLightedAyaNum < 1
        || highlightStatus.fromHighLightedAyaNum < 1) {
      highlightStatus.fromHighLightedAyaNum = ayaNum;
      highlightStatus.toHighLightedAyaNum = ayaNum;
    } else {
      if (ayaNum < highlightStatus.fromHighLightedAyaNum)
        highlightStatus.fromHighLightedAyaNum = ayaNum;
      else if (ayaNum > highlightStatus.toHighLightedAyaNum)
        highlightStatus.toHighLightedAyaNum = ayaNum;
    }
    this.highlightStatus=highlightStatus;
    emit(HighLightAyatTouchState());
  }

  unHighlightAya( HighlightStatus highlightStatus,
      int soraNum, int ayaNum ) {
    highlightStatus.soraNum = soraNum;
    if (ayaNum == highlightStatus.fromHighLightedAyaNum) {
      highlightStatus.fromHighLightedAyaNum = 0;
      highlightStatus.toHighLightedAyaNum = 0;
    } else {
      highlightStatus.toHighLightedAyaNum = ayaNum - 1;
    }
    this.highlightStatus=highlightStatus;
    emit(HighLightAyatTouchState());
  }

  emitAyaPlayingChange() {
    if(!isClosed)
    {
      emit(PlayHighlightState());
    }
  }

  void forgetAyaPlaying() {
    updateLatesthighlightedAya(-1, -1, 0);
    playerHighlightStatus.ayaNum = -1;
    playerHighlightStatus.soraNum = -1;
  }
}