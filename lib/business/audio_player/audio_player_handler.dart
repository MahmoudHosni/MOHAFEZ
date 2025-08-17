import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// An [AudioHandler] for playing a single item.
class AudioPlayerHandler extends BaseAudioHandler
    with SeekHandler
{

  final audioPlayer = AudioPlayer();
  MediaItem? notificationMediaItem ;
  bool isPaused = false;
  /// Initialise our audio handler.
  AudioPlayerHandler() {
    audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
      final playing = audioPlayer.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          //MediaControl.skipToPrevious,
          MediaControl.rewind,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.fastForward,
          //MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[audioPlayer.loopMode]!,
        shuffleMode: (audioPlayer.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      ));
    }, // Catching errors during playback (e.g. lost network connection) // tested and worked in case of invalid url
        onError: (Object e, StackTrace st) async {
          await stopAudio();
        });

    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    //audioPlayer.playbackEventStream.map(transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.

    audioPlayer.currentIndexStream.listen((currentIndex) {
      if (currentIndex == null) return;
      if(currentIndex==1)
      {
        prefixFinished();
      }
    });

    _listenToCurrentPosition();
    _listenForDurationChanges();
    _listenToPlaybackState();
  }

  void _listenToPlaybackState() {
    playbackState.listen((playbackState) async {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      }
      else if (processingState == AudioProcessingState.idle ) {
        //await stopAudio();
        buttonNotifier.value = ButtonState.completed;
      }
      else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        // await stopAudio();
        await pause();
        buttonNotifier.value = ButtonState.completed;
        await audioSourceCompletedOrStopped();
      }

      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: audioPlayer.duration==null?Duration.zero : audioPlayer.duration!,
      );

    }, onError: (Object e, StackTrace st)  {

    });
  }

  void _listenToCurrentPosition() {
    audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: audioPlayer.duration==null? Duration.zero:audioPlayer.duration!,
      );
    });
  }

  @override
  Future<void> play() async {
    if(!isPaused) {
          if (audioPlayer.processingState == ProcessingState.idle
              || audioPlayer.processingState == ProcessingState.ready) {
            await setAudioSource();
          }
        }
        await audioPlayer.play();
        isPaused = false;
  }

  @override
  Future<void> playWithoutSource() async {
    await audioPlayer.play();
    isPaused = false;
  }

  Future<void> resume() async{
    isPaused = false;
    await audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    isPaused=true;
    await audioPlayer.pause();//comment as it is required to stop not pause
    // await stop();
  }

  @override
  Future<void> seek(Duration position) async {
    //called from seek by user in notification and also from fastForward and rewind
    await audioPlayer.seek(position,index: audioPlayer.currentIndex);
  }

  @override
  Future<void> stop() async {
    isPaused = false;
    await stopAudio();
  }

  @override
  Future<void> fastForward() async {
    var seekDuration = Duration(seconds: audioPlayer.position.inSeconds+10);
    seek(seekDuration);
  }
  @override
  Future<void> rewind() async {
    var seekDuration = Duration(seconds: audioPlayer.position.inSeconds-10);
    seek(seekDuration);
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> dispose() async {
    await audioPlayer.dispose();
  }

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  setAudioSource(){}
  prefixFinished(){}
  audioSourceCompletedOrStopped(){}
  void _listenForDurationChanges() {
    //if we comment this code i.e: mediaItem has duration = null then seekbar in notification is supposed to be hidden
    //and also commenting this will solve the issue of "player notification sometimes not removed when click stop
    // from app ui or from notification" but note this code is important to make fastForward and rewind work but also they still
    //need this line await audioPlayer.seek(position,index: audioPlayer.currentIndex)
    //in @override
    //   Future<void> seek(Duration position)
    // audioPlayer.durationStream.listen((duration) {
    //   var index = audioPlayer.currentIndex;
    //   if (index == null ) return;
    //   if (audioPlayer.shuffleModeEnabled) {
    //     index = audioPlayer.shuffleIndices![index];
    //   }
    //   final newMediaItem = mediaItem.valueOrNull?.copyWith(duration: duration);
    //   mediaItem.add(newMediaItem);
    //   final oldState = progressNotifier.value;
    //   progressNotifier.value = ProgressBarState(
    //     current: oldState.current,
    //     buffered: oldState.buffered,
    //     total: mediaItem.valueOrNull?.duration ?? Duration.zero,
    //   );
    // });
  }
}


class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });

  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading,completed }