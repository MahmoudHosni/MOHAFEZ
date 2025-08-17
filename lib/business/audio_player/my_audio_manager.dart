import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
// import 'package:helpers/helpers.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'PlayerUtils.dart';
import 'audio_player_handler.dart';
import 'media_info.dart';

Future<MyAudioManager> initAudioService() async {
  await copyPlayerNotificationIconToAppFolder();
  return await AudioService.init(
    builder: () => MyAudioManager(),
    config: const AudioServiceConfig(preloadArtwork: true,
      androidNotificationChannelId: "com.arabiait.quran.v2",
      androidNotificationChannelName: 'audio player',
      notificationColor: Color.fromARGB(255, 81, 102, 255),
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon : 'mipmap/ic_stat_notifications',
    ),
  );
}

class MyAudioManager extends AudioPlayerHandler {
  static int SimpleMediaId = -1;
  static int NotPlayingSoundClipPos = -1;
  static int AudioCompletedAyaNum = -1;
  static int AudioPausedAyaNum = -5;
  late MediaInfo mediaInfo;
  int startTime = 0;
  int endTime = 0;
  int currentPlayingSoundClipPos = NotPlayingSoundClipPos;
  double speed=1;
  int currentPlayingSoraNum = 0;
  int currentPlayingAyaNum = 0;
  int clipRepeatCount = 0;
  int rangeRepeatCount = 0;
  ConcatenatingAudioSource playList = ConcatenatingAudioSource(children: []);
  bool timerIsRunning = false;
  bool withTimer = true;

  Future<void> playSound(MediaInfo mediaInfo, int readerId, int soraNum,
      String notificationTitle, String notificationContent,bool willResetSetting) async {
    withTimer = true;
    currentPlayingSoraNum=soraNum;
    this.mediaInfo = mediaInfo;
    String artUri = await getPlayerNotificationIconPath();
    String mediaItemId = "";
    if(mediaInfo.id==SimpleMediaId)
    {
      mediaItemId=mediaInfo.path;
    }
    else
    {
      mediaItemId = "$readerId-$soraNum" ;
    }
    notificationMediaItem = MediaItem(
        id:    mediaItemId,
        album: notificationTitle,
        title: notificationContent,
        artUri: Uri.parse(artUri)
    );
    mediaItem.add(notificationMediaItem);
    if(willResetSetting){
      adjustSpeed(1);
    }else{
      adjustSpeed(speed);
    }
    play();
  }

  @override
  setAudioSource() async {
    if(mediaInfo.id!=SimpleMediaId)
    {
      await playList.clear();//await is important
      if (mediaInfo.prefixSoundRawId != null) {
        await playList.add(AudioSource.uri(Uri.parse('asset:/${mediaInfo.prefixSoundRawId}'), tag: notificationMediaItem));
      }

      startTime = (mediaInfo.soundClips[0].timeFrom * 1000).toInt();
      endTime = (mediaInfo.soundClips[mediaInfo.soundClips.length - 1].timeTo * 1000).toInt();

      if (mediaInfo.isLocal) {
        await playList.add(ClippingAudioSource(
            start: Duration(milliseconds: startTime),
            end: Duration(milliseconds: endTime),
            child: AudioSource.uri(Uri.file(mediaInfo.path)),
            tag: notificationMediaItem));
      } else {
        await playList.add(ClippingAudioSource(
            start: Duration(milliseconds: startTime),
            end: Duration(milliseconds: endTime),
            child: AudioSource.uri(Uri.parse(mediaInfo.path)),
            tag: notificationMediaItem));
      }
      try {
        await audioPlayer.setAudioSource(playList);
      }  catch (e, stackTrace){
        print('MyPlayerError occured: $e');
      }
    }
    else
    {
      try {
        await audioPlayer.setAudioSource(AudioSource.uri(
            Uri.parse(mediaInfo.path),
            tag: notificationMediaItem));
      }  catch (e, stackTrace){
        print('MyPlayerError occured: $e');
      }
    }
  }

  @override
  prefixFinished() {
    if(withTimer)
    startTimer();
  }

  void startTimer() {
    if(mediaInfo.id!=SimpleMediaId)
  {
    timerIsRunning = true;
    currentPlayingSoundClipPos=0;
    Timer.periodic(const Duration(milliseconds: 100), (Timer timer) async {
      if (!timerIsRunning) {
        timer.cancel();
      }

      if(currentPlayingSoundClipPos!=NotPlayingSoundClipPos) {
        if (mediaInfo.soundClips[currentPlayingSoundClipPos].timeTo * 1000 - (audioPlayer.position.inMilliseconds + startTime) <= 250) {
          if (rangeRepeatCount < mediaInfo.rangeRepeatCount) {
            clipRepeatCount++;
            if (clipRepeatCount < mediaInfo.clipRepeatCount) {
              await playerSeek();
            } else {
              currentPlayingSoundClipPos++;
              clipRepeatCount = 0;
              if (currentPlayingSoundClipPos >= mediaInfo.soundClips.length) {
                rangeRepeatCount++;
                clipRepeatCount = 0;
                currentPlayingSoundClipPos = 0;
                if (rangeRepeatCount < mediaInfo.rangeRepeatCount) {
                  await playerSeek();
                } else {
                  await stopAudio();
                }
              }
            }
          } else {
            await stopAudio();
          }
        }
      }
      if(currentPlayingSoundClipPos!=NotPlayingSoundClipPos)
      {
        if ((audioPlayer.position.inMilliseconds + startTime) - (mediaInfo.soundClips[currentPlayingSoundClipPos].timeFrom * 1000) <= 150) {
          notifyCurrentAyaPlaying();
        }
      }
    });
   }
  }

  playerSeek() async {
    await audioPlayer.seek(
        Duration(
            milliseconds:
            (mediaInfo.soundClips[currentPlayingSoundClipPos].timeFrom *
                1000)
                .toInt() -
                startTime),
        index: 1);
  }

  void notifyCurrentAyaPlaying() {
    currentPlayingAyaNum = mediaInfo.soundClips[currentPlayingSoundClipPos].id;
    currentAyaNotifier.value = currentPlayingAyaNum;
  }

  @override
  audioSourceCompletedOrStopped() {
    // currentAyaNotifier.value = AudioCompletedAyaNum;
    currentAyaNotifier.value = AudioPausedAyaNum;
  }

  @override
  Future<void> stop() async {
    await stopAudio();
    await playList.clear();
  }

  @override
  Future<void> stopAudio() async {
    await super.stopAudio();
    await resetPlayer();
  }

  resetPlayer() {
    resetTimer();
    playList = ConcatenatingAudioSource(children: []);
    currentAyaNotifier.value = AudioPausedAyaNum;
    currentPlayingSoundClipPos = NotPlayingSoundClipPos;
    currentPlayingSoraNum = 0;
    currentPlayingAyaNum = 0;
    rangeRepeatCount = 0;
    clipRepeatCount = 0;
  }

  void resetTimer() {
    timerIsRunning = false;
  }
  final currentAyaNotifier = ValueNotifier<int>(0);
  final List<VoidCallback> counterListeners = [];

  void adjustSpeed(double sp) {
    if(sp!=speed) {
      speed = sp;
      this.audioPlayer.setSpeed(sp);
    }
  }

  playNewList(ConcatenatingAudioSource _playlist,int index) {
    withTimer = false;
    playList = _playlist;
    audioPlayer.setAudioSource(playList, initialIndex: index, initialPosition: Duration.zero,);
  }

  void stopAudioNow() {
    super.stopAudio();
  }

  void removeAllListeners() {
    print("Listeners count >> ${counterListeners.length}");
    for (var listener in counterListeners) {
      currentAyaNotifier.removeListener(listener);
      print("remove listener");
    }
  }

  void addCountCallback(listener) {
    currentAyaNotifier.addListener(listener);
    counterListeners.add(listener);
  }
}