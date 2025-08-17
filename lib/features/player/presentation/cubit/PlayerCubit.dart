import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../business/audio_player/FileUtils.dart';
import '../../../../business/audio_player/audio_player_handler.dart';
import '../../../../business/audio_player/media_info.dart';
import '../../../../business/audio_player/my_audio_manager.dart';
import '../../../../core/databases/readers/RepeatDataSource.dart';
import '../../../../core/entity/player/Reader.dart';
import '../../../../core/entity/player/ReaderAya.dart';
import '../../../../core/entity/quran/Sora.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/app_util.dart';
import '../../../fahres/domain/use_cases/GetSoraUsecase.dart';
import '../../../quran_show/presentation/cubit/AyatHighlightCubit.dart';
import '../../domain/use_cases/GetAyatFromDuration.dart';
import '../../domain/use_cases/GetRangeAyatInSoraUsecase.dart';
import '../../domain/use_cases/GetSelectedReaderUsecase.dart';
import 'HighlightStatus.dart';
import 'PlayerHighlightStatus.dart';
import 'PlayingState.dart';
import 'package:flutter/material.dart';

class PlayerCubit extends Cubit<PlayingState>{
  final GetAyatFromDuration getAyatFromDuration;
  final GetRangeAyatInSoraUsecase getRangeAyatInSoraUsecase;
  final GetSelectedReaderUsecase selectedReaderUsecase;
  final RepeatDataSource repeatDataSource;
  final GetSoraUsecase soraUsecase;
  final MyAudioManager myAudioManager ;
  bool willContinueTillEnd = false;
  int rangeRepeatCount = 1;
  int ayaRepeatCount = 1;
  int playSpeed=1;
  double speed=1;
  Sora? sora;
  int ayaFrom=1;
  int TahfezAyaFrom = 1;
  int TahfezAyaTo =3;
  int ayaTo=3;
  int soraNum = 1;
  int firstPageNum = 0;
  String soraName = '';
  Reader? reader;
  int? currentPage;
  Function? listener;

  static PlayerCubit get(context)=>BlocProvider.of(context);

  PlayerCubit({required this.selectedReaderUsecase,required this.getRangeAyatInSoraUsecase,required this.myAudioManager,required this.repeatDataSource,required this.soraUsecase,required this.getAyatFromDuration}):super(PlayState());

  void loadSetting(BuildContext context,AyatHighlightCubit highLightAyatCubit){
    repeatDataSource.getRepeatedAyaCount().then((value) => ayaRepeatCount = value??1);
    repeatDataSource.getRepeatedRangeCount().then((value) => rangeRepeatCount = value??1);
  }

  void setPlayerData(AyatHighlightCubit highLightAyatCubit, PlayerHighlightStatus playerHighlightStatus,BuildContext context,Reader _reader,bool contineTillEnd) async {
    willContinueTillEnd = contineTillEnd;
    reader = _reader;
    int ayaFrom = this.ayaFrom;
    int ayaTo = this.ayaTo;
    soraNum = playerHighlightStatus.soraNum;
    print("Update sora no here :::: setPlayerData   $soraNum");
    int fromHighLightedAyaNum = highLightAyatCubit.highlightStatus.fromHighLightedAyaNum;
    int toHighLightedAyaNum = highLightAyatCubit.highlightStatus.toHighLightedAyaNum;
    if (fromHighLightedAyaNum > 0 && toHighLightedAyaNum > 0) {
      ayaFrom = fromHighLightedAyaNum;
      ayaTo = toHighLightedAyaNum;
    }

    playerHighlightStatus.ayaNum=ayaFrom;
    highLightAyatCubit.playerHighlightStatus = playerHighlightStatus;

    getRangeAyatInSoraUsecase.call(soraNum, ayaFrom, ayaTo).then((value) => {
        onGetAyatInRange(value,context)
    });
  }

  void observeCurrentAyaPlaying(BuildContext context,AyatHighlightCubit highLightAyatCubit) {
    listener ??= () => onCurrentAyaChange(context, highLightAyatCubit);
    removeCountNotifierListeners();
    myAudioManager.audioPlayer.setLoopMode(LoopMode.off);
    myAudioManager.addCountCallback(listener);
  }

   void initalizeMediaAndStart({required BuildContext context, required String path, required bool isLocal, required List<SoundClip> soundClips}) {
      MediaInfo mediaInfo = MediaInfo(id: soraNum, path: path, isLocal: isLocal, soundClips: soundClips);
      mediaInfo.rangeRepeatCount=rangeRepeatCount;
      mediaInfo.clipRepeatCount=ayaRepeatCount;
      if (soraNum == 1 || ayaFrom > 1) {
        mediaInfo.prefixSoundRawId = "${Constants.assetsSoundsFolder}est3aza_sound${Constants.extensionMp3}";
      } else if (ayaFrom > 1) {
        mediaInfo.prefixSoundRawId = "${Constants.assetsSoundsFolder}est3aza_sound${Constants.extensionMp3}";
      } else {
        mediaInfo.prefixSoundRawId = "${Constants.assetsSoundsFolder}est3aza_basmla_sound${Constants.extensionMp3}";
      }
      myAudioManager.setSpeed(speed);
      myAudioManager.playSound(mediaInfo, reader!.id, soraNum, 'المحفظ', soraName,false);
  }

  onGetAyatInRange(List<ZAYA> list, BuildContext context) async{
    List<SoundClip> soundClips = list.map((e) => SoundClip.fromReaderAya(e)).toList();
    bool isLocal = false;
    String path = "";
    bool fileDownloaded = await getTelawaDownloadStatus(reader!.id, soraNum);
    if (fileDownloaded)   {
      isLocal = true;
      path = await getDownloadedSoraPath(reader!.id, soraNum);
    }
    else {
      path =  getLinkReaderSora(reader!.id,reader!.soraUrl, soraNum);
    }
    bool hasNetwork = await InternetConnectionChecker().hasConnection;
    if(!isLocal&&!hasNetwork) {
      Constants.showToast(context.loc()?.no_internet_message??"");
    } else {
      initalizeMediaAndStart(context:context,path: path, isLocal: isLocal, soundClips: soundClips);
    }
  }

  ValueNotifier<ButtonState> getButtonNotifier(){
    return myAudioManager.buttonNotifier;
  }

  ValueNotifier<ProgressBarState> getProgressNotifier(){
    return myAudioManager.progressNotifier;
  }

  bool isPlaying(){
    return myAudioManager.audioPlayer.playing;
  }

  void stopSound() {
    willContinueTillEnd =false;
    myAudioManager.stop();
  }

  void stopAudio() {
    myAudioManager.stopAudio();
  }

  void pause() {
    myAudioManager.pause();
  }

  void resume(){
    myAudioManager.resume();
  }

  void seekSecondsPrevious() {
    myAudioManager.rewind();
  }

  void seekSecondsForward() {
    myAudioManager.fastForward();
  }

  void seekToDuration(Duration dr){
    myAudioManager.seek(dr);
  }

  void changeReader(int id) {
    reader = readers[id];
    stopSound();
  }

  int getRepeatOfAya(){
    return ayaRepeatCount;
  }

  increaseRepeatOfAya(){
    ayaRepeatCount++;
    if(ayaRepeatCount>9){
      ayaRepeatCount=1;
    }
    repeatDataSource.saveRepeatedAyaCount(ayaRepeatCount);
  }

  resetRepeat(){
    rangeRepeatCount = 1;
    ayaRepeatCount = 1;
  }

  decreaseRepeatOfAya(){
    if(ayaRepeatCount<=1) return;
    ayaRepeatCount--;
    if(ayaRepeatCount<=1){
      ayaRepeatCount=1;
    }
    repeatDataSource.saveRepeatedAyaCount(ayaRepeatCount);
  }

  int getRepeatOfRange(){
    return rangeRepeatCount;
  }

  increaseRepeatOfRange(){
    rangeRepeatCount++;
    if(rangeRepeatCount>9){
      rangeRepeatCount=1;
    }
    repeatDataSource.saveRepeatedRangeCount(rangeRepeatCount);
  }

  decreaseRepeatOfRange(){
    if(rangeRepeatCount<=1) return;
    rangeRepeatCount--;
    if(rangeRepeatCount<=1){
      rangeRepeatCount=1;
    }
    repeatDataSource.saveRepeatedRangeCount(rangeRepeatCount);
  }

  int getPlayerSpeed(){
    myAudioManager.adjustSpeed(playSpeed.toDouble());
    return playSpeed;
  }

  increasePlayerSpeed(){
    playSpeed++;
    if(playSpeed>3){
      playSpeed=1;
      setSpeed(1);
    }else{
      if(playSpeed==1) {
        setSpeed(1);
      }
      else if(playSpeed==2) {
        setSpeed(1.25);
      }
      else {
        setSpeed(1.5);
      }
    }
  }

  void setSpeed(double sp) {
    speed = sp;
    myAudioManager.adjustSpeed(sp);
  }

  Future<Reader?> getReader(){
    return selectedReaderUsecase.call();
  }

  Future<Sora?> getSora(int id){
    return soraUsecase.call(id);
  }

  void tryPlayNextSora(BuildContext context,AyatHighlightCubit highLightAyatCubit) {
    if(willContinueTillEnd&&soraNum<114){
      print("Update sora no here :::: tryPlayNextSora ${soraNum}");
      soraNum ++;
      print("Update sora no here :::: tryPlayNextSora ${soraNum}");
      getSora(soraNum).then((value) => playNextSora(value,context,highLightAyatCubit));
    }else if(willContinueTillEnd&&soraNum>114){
      ayaFrom=1;
      ayaTo = 1;
      soraNum=1;
      stopSound();
    }
  }

  Future<List<ZAYA>> getAyatOfDuration(int soraNum,Duration dr){
    return getAyatFromDuration.call(soraNum, dr.inMilliseconds.toDouble()/1000);
  }

  playNextSora(Sora? sr,BuildContext context,AyatHighlightCubit highLightAyatCubit) {
    ayaFrom=1;
    ayaTo = sr?.AyatCount ??1;
    print("END playing ):): $soraNum");
    HighlightStatus status = HighlightStatus();
    sora =  sr;
    status.soraNum = sr?.Id ??1;
    status.fromHighLightedAyaNum = 1 ;
    status.toHighLightedAyaNum = ayaTo;
    highLightAyatCubit.highlightStatus = status;

    setPlayerData(highLightAyatCubit,PlayerHighlightStatus.our_constructor(sr?.Id ??1, sora?.PageNum ??0, 1),context,reader!,willContinueTillEnd);
  }

  void onCurrentAyaChange(BuildContext context,AyatHighlightCubit highLightAyatCubit) {
      int ayaNum =  myAudioManager.currentAyaNotifier.value;
      print("current playing aya :: $ayaNum");
      if(ayaNum==MyAudioManager.AudioCompletedAyaNum) {
        PlayerHighlightStatus playerHighlightStatus = highLightAyatCubit.playerHighlightStatus;
        playerHighlightStatus.clear();
        highLightAyatCubit.playerHighlightStatus = playerHighlightStatus;
        highLightAyatCubit.emitAyaPlayingChange();
        highLightAyatCubit.getHighlightOfPlayingAya(0, 0);
      }else if(ayaNum==MyAudioManager.AudioPausedAyaNum) {
        PlayerHighlightStatus playerHighlightStatus = highLightAyatCubit.playerHighlightStatus;
        highLightAyatCubit.playerHighlightStatus = playerHighlightStatus;
        print("calling >>>>>>  tryPlayNextSora(context,highLightAyatCubit)");
        tryPlayNextSora(context,highLightAyatCubit);
      }else if(soraNum==myAudioManager.mediaInfo.id) {
        PlayerHighlightStatus playerHighlightStatus = highLightAyatCubit.playerHighlightStatus;
        playerHighlightStatus.soraNum =soraNum;
        playerHighlightStatus.ayaNum = ayaNum;
        highLightAyatCubit.playerHighlightStatus = playerHighlightStatus;
        highLightAyatCubit.getHighlightOfPlayingAya(soraNum, ayaNum);
        highLightAyatCubit.emitAyaPlayingChange();
      }
  }

  void removeCountNotifierListeners() {
    myAudioManager.removeAllListeners();
  }
}