import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohafez/core/entity/quran/Sora.dart';
import 'package:mohafez/features/quran_show/presentation/cubit/QuranPageCubit.dart';
import 'package:mohafez/features/quran_show/presentation/pages/QuranPageViewer.dart';
import 'package:mohafez/utils/Constants.dart';
import 'core/di/InjectionContainer.dart' as si;

class CandyCrushMap extends StatefulWidget {
  const CandyCrushMap({super.key});

  @override
  State<StatefulWidget> createState() => _CandyCrushMapState();
}

class _CandyCrushMapState extends State<CandyCrushMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer( // pinch zoom and pan optional
        minScale: 1,
        maxScale: 1,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background map
              Image.asset(
                "assets/images/bg1.png",
                fit: BoxFit.fitWidth,
                height: 4100, // long map
                width: MediaQuery.of(context).size.width,
              ),

              // Levels positioned on the path
              Positioned(
                top: 3800,
                left: 200,
                child: LevelNode(title: "البقرة", stars: 2, completed: true),
              ),
              Positioned(
                top: 400,
                right: 450,
                child: LevelNode(title: "آل عمران", stars: 1, completed: true),
              ),
              Positioned(
                top: 600,
                left: 160,
                child: LevelNode(title: "النساء", stars: 1, completed: false),
              ),
              Positioned(
                top: 800,
                right: 150,
                child: LevelNode(title: "المائدة", stars: 0, completed: false),
              ),
              // Add more...
            ],
          ),
        ),
      ),
    );
  }
}

class LevelNode extends StatelessWidget {
  final String title;
  final int stars;
  final bool completed;

  const LevelNode({
    super.key,
    required this.title,
    required this.stars,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              BlocProvider(create: (context) => QuranPageCubit(ayatPositionUsecase: si.di(),
                                                      ayatPositionsInRange: si.di(),
                                                      pageInfo: si.di(),
                                                      isPagesRight: si.di(),
                                                      getLastPageOpenedUsecase: si.di(),
                                                      savePageUsecase: si.di(),getFirstAyaInPageUsecase: si.di(), getAyaBySora: si.di(),),
                            child:QuranPageViewer(sora: Sora(1,"الفاتحة",  7, 1, 1, "الفاتحة", "الفاتحة", "الفاتحة", 1, 7),))
            ));
      },
      child:
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/crt.png",width: 150,height: 200 ,),
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 80),child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                child: Text(
                  title,
                  style: TextStyle(color: completed? Colors.yellow : Colors.white, fontSize: 33.0,fontWeight: FontWeight.bold,fontFamily: "Farah"),
                  textAlign: TextAlign.center,
                ),
              ),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    return Image.asset( index < stars ? Constants.Star : Constants.EmptyStar,fit: BoxFit.cover,
                      width: 19,
                    );
                  }),
                ),
              ),
            ],
          ),
    );
  }
}