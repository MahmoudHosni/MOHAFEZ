import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohafez/core/extensions/extensions.dart';
import 'package:mohafez/core/theme/dark_mode/themes/custom_themedata_ext.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../business/audio_player/audio_player_handler.dart';
import '../../../../core/entity/player/Reader.dart';
import '../../../../core/theme/color_manager.dart';
import '../../../../utils/Constants.dart';
import '../../../quran_show/domain/quran_util/QuranUtils.dart';
import '../../../quran_show/presentation/cubit/AyatHighlightCubit.dart';
import '../cubit/HighlightStatus.dart';
import '../cubit/PlayerCubit.dart';
import '../cubit/PlayerHighlightStatus.dart';
import '../cubit/ReadersCubit.dart';

class CurrentPlayingView extends StatefulWidget{
  final int index;

  CurrentPlayingView({required this.index});

  @override
  State<CurrentPlayingView> createState() => _CurrentPlayingViewState();
}

class _CurrentPlayingViewState extends State<CurrentPlayingView> {
  ProgressBarState progress = ProgressBarState(current: Duration.zero, buffered: Duration.zero, total: Duration.zero);
  late PlayerCubit playerCubit;
  late ReadersCubit readersCubit;
  late AyatHighlightCubit highlightCubit;
  bool isPlaying = false;
  bool paused = false;

  @override
  void initState() {
    super.initState();
    playerCubit = PlayerCubit.get(context);
    highlightCubit = AyatHighlightCubit.get(context);
    readersCubit = ReadersCubit.get(context);
    intalizeRequiredData();
  }

  @override
  void deactivate() {
    playerCubit.getProgressNotifier().removeListener(() {
      onProgressChange();
    });
    playerCubit.getButtonNotifier().removeListener(() {
      onNotificationButtonPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    isPlaying = playerCubit.isPlaying();
    return Material(
      child: ((isPlaying || paused) && widget.index ==0)? Container(color:  Theme.of(context).soraPlayerBg,
          margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          alignment: Alignment.bottomLeft,height: 62.0.toValue(context),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,textDirection: TextDirection.rtl,
                children: [
                  SizedBox(
                      height: 50.0.toValue(context),
                      width: 70.0.toValue(context),
                      child: FadeInImage(
                        image:NetworkImage("https://gquran.arabia-it.net/storage/surahs/${playerCubit.soraNum}.jpg"),
                        placeholder: const AssetImage('assets/drawables/thump_def_player.png') ,
                         fit: BoxFit.fill,
                      ),),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text("${QuranUtils.SoraNames()[playerCubit.soraNum-1]} " ??'',
                          style: TextStyle(
                            fontSize: 19.0.toValue(context),
                            fontFamily: "",
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).black,
                            decoration: TextDecoration.none,
                          )),
                      Text(" ${playerCubit.reader?.getName(context)}" ??'',
                          style: TextStyle(
                            fontSize: 10.5.toValue(context),
                            fontFamily: 'IBM',
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).readersSearchIconBg,
                            decoration: TextDecoration.none,
                          ))
                    ],),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(child:Container(height: 40, width: 40, decoration: const BoxDecoration(color: ColorManager.newBlue, shape: BoxShape.circle,),padding: const EdgeInsets.all(7),
                    child: isPlaying?
                    SvgPicture.asset("${Constants.SvgPath}ic_pause.svg",color: Colors.white,) : SvgPicture.asset("${Constants.SvgPath}ic_play.svg",color: Colors.white,),
                  ),onTap: () {
                    playSound(context);
                  }),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      child: SvgPicture.asset("${Constants.SvgPath}close_player.svg",height: 23, width: 23,color: Theme.of(context).readersSearchIconBg, )  ,
                      onTap: () {
                        stopSound();
                      }),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),onTap: (){
                // openReadersSheet(context);
              },),
              Container( alignment: Alignment.center,color: Colors.transparent,height: 3,
                child: Center(
                  child: LinearPercentIndicator(
                    width: 350,// context.mediaQuerySize.width -56 ,
                    animation: true,
                    animationDuration: 0,
                    lineHeight: 2.0,
                    isRTL: true,
                    percent: isPlaying ? (progress.current.inMilliseconds / progress.total.inMilliseconds).abs() > 1
                        ? (1 -((progress.current.inMilliseconds / progress.total.inMilliseconds).abs().toDouble())).abs(): (progress.current.inMilliseconds / progress.total.inMilliseconds).abs().toDouble()
                        : 0,
                    barRadius: const Radius.circular(7),
                    alignment: MainAxisAlignment.end,
                    progressColor: ColorManager.primary ,
                    backgroundColor: Colors.black12,
                  ),
                ),
              ),
            ],
          )
      ):const SizedBox(),
    );
  }

  Future<void> playSound(BuildContext context) async {
    if (isPlaying) {
      pausePlayer();
    } else {
      if (paused == true) {
        resumePlayer();
      } else {
        HighlightStatus status = HighlightStatus();
        status.soraNum = playerCubit.soraNum ;
        status.fromHighLightedAyaNum = playerCubit.ayaFrom ;
        status.toHighLightedAyaNum = QuranUtils.AyatInSoraCount()[playerCubit.soraNum - 1];
        highlightCubit.highlightStatus = status;
        paused = false;
        readersCubit.getSelectedReader().then((value) =>  playerCubit.setPlayerData(
          highlightCubit,
          PlayerHighlightStatus.our_constructor(playerCubit.soraNum, playerCubit.currentPage??0, playerCubit.ayaFrom),
          context,readers[value??0]!,playerCubit.willContinueTillEnd));
        playerCubit.resetRepeat();
        playerCubit.observeCurrentAyaPlaying(context,highlightCubit);
        playerCubit.getButtonNotifier().addListener(() {
          onNotificationButtonPressed();
        });
        setState(() {
          isPlaying = true;
        });
        // updateIfMounted();
      }
    }
  }

  void onNotificationButtonPressed() {
    var state = playerCubit.getButtonNotifier().value;
    if (state == ButtonState.paused) {
      pausePlayer();
    } else if (state == ButtonState.playing) {
      resumePlayer();
    } else if (state == ButtonState.completed) {
      stopSound();
    }
  }

  void pausePlayer() {
    setState(() {
      paused = true;
      playerCubit.pause();
    });
  }

  void resumePlayer() {
    setState(() {
      paused = false;
      playerCubit.resume();
    });
  }

  void stopSound() {
    playerCubit.removeCountNotifierListeners();

    setState(() {
      isPlaying = false;
      paused = false;
      playerCubit.stopSound();
      highlightCubit.forgetAyaPlaying();
    });
  }

  void onProgressChange() {
    if(mounted) {
      setState(() {
          progress = playerCubit.getProgressNotifier().value;
      });
    }
  }

  void intalizeRequiredData() {
    playerCubit.getProgressNotifier().addListener(() {
      onProgressChange();
    });
  }
}