import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohafez/core/databases/DatabaseCopy.dart';
import 'CandyCrushMap.dart';
import 'core/cache/DataPreference.dart';
import 'core/di/InjectionContainer.dart' as si;
import 'core/theme/dark_mode/cubit/theme_cubit.dart';
import 'features/fahres/presentation/cubit/FahresCubit.dart';
import 'features/player/presentation/cubit/PlayerCubit.dart';
import 'features/player/presentation/cubit/ReadersCubit.dart';
import 'features/quran_show/presentation/cubit/AyatHighlightCubit.dart';
import 'features/quran_show/presentation/cubit/QuranPageCubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseCopy().copyDBs();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  await si.init();
  await DataPreference.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  MultiBlocProvider(
            providers: [
                BlocProvider(create: (context) => ThemeCubit()..init()),
                BlocProvider(
                  create: (BuildContext context) => QuranPageCubit(
                        ayatPositionUsecase: si.di(),
                        ayatPositionsInRange: si.di(),
                        pageInfo: si.di(),
                        isPagesRight: si.di(),
                        getLastPageOpenedUsecase: si.di(),
                        savePageUsecase: si.di(),
                        getFirstAyaInPageUsecase: si.di(), getAyaBySora: si.di(),)),
                BlocProvider(
                  create: (BuildContext context) => AyatHighlightCubit(
                        rectsFromTouchEvent: si.di(), playingAyaRectangles: si.di())),
                BlocProvider(
                  create: (BuildContext context) => PlayerCubit(
                        getRangeAyatInSoraUsecase: si.di(),
                        selectedReaderUsecase: si.di(),
                        myAudioManager: si.di(),
                        repeatDataSource: si.di(),
                        soraUsecase: si.di(),
                        getAyatFromDuration: si.di())),
                BlocProvider(
                  create: (BuildContext context) =>ReadersCubit(readersPrefsDataSource: si.di())),
                BlocProvider(create: (BuildContext context) => FahresCubit(
                        allAjzaUsecase: si.di(),
                        sorasUsecase: si.di(),
                        searchInSorasUsecase: si.di(),
                        searchInAjzaUsecase: si.di(),
                        getAjuzaWithQuarters: si.di(),
                )),
            ],
            child: const CandyCrushMap(),
    ));
  }
}