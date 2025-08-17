
import '../../../core/entity/player/ReaderAya.dart';

class MediaInfo {
  int id = 0;
  String path = "";
  bool isLocal = false;
  List<SoundClip> soundClips;
  int rangeRepeatCount = 1;
  int clipRepeatCount = 1;
  String notificationTitle = "";
  String? prefixSoundRawId;

  MediaInfo({required this.id, required this.path, required this.isLocal
    , required this.soundClips});

}

class SoundClip {
  final int id;
  final double timeFrom;
  final double timeTo;

  factory SoundClip.fromReaderAya(ZAYA readerAya) {
    return SoundClip(
      id: readerAya.ZAYANUM,
      timeFrom: readerAya.ZFROMTIME,
      timeTo: readerAya.ZTOTIME,
    );
  }

  SoundClip({required this.id, required this.timeFrom, required this.timeTo});
}
