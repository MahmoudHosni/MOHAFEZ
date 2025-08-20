import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../business/audio_player/my_audio_manager.dart';
import '../../features/fahres/data/data_sources/FahresLocalDataSource.dart';
import '../../features/fahres/data/repositories/FahresRepositoryImpl.dart';
import '../../features/fahres/domain/repostories/FahresRepository.dart';
import '../../features/fahres/domain/use_cases/GetAjuzaWithQuarters.dart';
import '../../features/fahres/domain/use_cases/GetAllAjzaUsecase.dart';
import '../../features/fahres/domain/use_cases/GetAllSuras.dart';
import '../../features/fahres/domain/use_cases/GetFirstAyaInPageUsecase.dart';
import '../../features/fahres/domain/use_cases/GetJuzaUsecase.dart';
import '../../features/fahres/presentation/cubit/FahresCubit.dart';
import '../../features/player/data/data_sources/PlayerDataSource.dart';
import '../../features/player/domain/use_cases/GetRangeAyatInSoraUsecase.dart';
import '../../features/player/domain/use_cases/GetSelectedReaderUsecase.dart';
import '../../features/player/domain/use_cases/GetSoraPagesInRangeUsecase.dart';
import '../../features/player/presentation/cubit/PlayerCubit.dart';
import '../../features/quran_show/data/data_sources/AyatPositionDataSource.dart';
import '../../features/quran_show/data/data_sources/QuranPagesInfoSource.dart';
import '../../features/quran_show/data/data_sources/RectanglesDataSource.dart';
import '../../features/quran_show/data/repository/AyatPositionRepoImpl.dart';
import '../../features/quran_show/data/repository/PageInfoRepoImpl.dart';
import '../../features/quran_show/domain/repo/AyatPositionRepo.dart';
import '../../features/quran_show/domain/repo/PageInfoRepo.dart';
import '../../features/quran_show/domain/use_case/GetAyaBySora.dart';
import '../../features/quran_show/domain/use_case/GetAyatPositionsInPage.dart';
import '../../features/quran_show/domain/use_case/GetAyatPositionsInRange.dart';
import '../../features/quran_show/domain/use_case/GetLastPageOpenedUsecase.dart';
import '../../features/quran_show/domain/use_case/GetPageInfo.dart';
import '../../features/quran_show/domain/use_case/GetRectsFromTouchEvent.dart';
import '../../features/quran_show/domain/use_case/GetRectsOfAya.dart';
import '../../features/quran_show/domain/use_case/IsPagesRight.dart';
import '../../features/quran_show/domain/use_case/SavePageUsecase.dart';
import '../../features/quran_show/presentation/cubit/AyatHighlightCubit.dart';
import '../../features/quran_show/presentation/cubit/QuranPageCubit.dart';

final di = GetIt.instance;

Future<void> init() async {

  di.registerLazySingleton<QuranPageCubit>(() => QuranPageCubit(
      ayatPositionUsecase: di(),
      ayatPositionsInRange: di(),
      pageInfo: di(),
      isPagesRight: di(),
      getLastPageOpenedUsecase: di(),
      savePageUsecase: di(),getFirstAyaInPageUsecase: di(), getAyaBySora: di()));
  di.registerLazySingleton<AyatHighlightCubit>(() => AyatHighlightCubit(
      rectsFromTouchEvent: di(), playingAyaRectangles: di()));
  di.registerLazySingleton<PlayerCubit>(() => PlayerCubit(
      selectedReaderUsecase: di(),
      getRangeAyatInSoraUsecase: di(),
      myAudioManager: di(),
      repeatDataSource: di(),soraUsecase: di(),getAyatFromDuration: di()));
  di.registerLazySingleton<FahresCubit>(() => FahresCubit(
    allAjzaUsecase: di(),
    sorasUsecase: di(),
    searchInAjzaUsecase: di(),
    searchInSorasUsecase: di(),
    getAjuzaWithQuarters: di(),
  )); //

  di.registerLazySingleton<FahresRepository>(() => FahresRepositoryImpl(dataSource: di()));
  di.registerLazySingleton<PageInfoRepo>(() => PageInfoRepoImpl(quranPagesInfoSource: di(), preference: di()));
  di.registerLazySingleton<AyatPositionRepo>(() => AyatPositionRepoImpl(ayatPositionDataSource: di()));
  di.registerLazySingleton(() => GetAyatPositionsInPage(ayatPositionRepo: di()));
  di.registerLazySingleton(() => GetAyatPositionsInRange(ayatPositionRepo: di()));
  di.registerLazySingleton(() => GetRectsOfAya(rectanglesRepo: di()));
  di.registerLazySingleton(() => GetRectsFromTouchEvent(rectanglesRepo: di()));
  di.registerLazySingleton(() => GetPageInfo(pageInfoRepo: di()));
  di.registerLazySingleton(() => IsPagesRight(pageInfoRepo: di())); //
  di.registerLazySingleton(() => SavePageUsecase(pageInfoRepo: di()));
  di.registerLazySingleton(() => GetLastPageOpenedUsecase(pageInfoRepo: di()));

  di.registerLazySingleton(() => GetRangeAyatInSoraUsecase(playerRepo: di()));
  di.registerLazySingleton(() => GetSelectedReaderUsecase(playerRepo: di()));
  di.registerLazySingleton(() => GetSoraPagesInRangeUsecase(playerRepo: di()));
  di.registerLazySingleton(() => GetAyaBySora(pageInfoRepo: di()));

  di.registerLazySingleton(() => GetAllAjzaUsecase(fahresRepo: di()));
  di.registerLazySingleton(() => GetAjuzaWithQuarters(fahresRepo: di()));
  di.registerLazySingleton(() => GetAllSurasUsecase(fahresRepo: di()));
  di.registerLazySingleton(() => GetJuzaUsecase(fahresRepo: di()));

  di.registerLazySingleton<RectanglesDataSource>(() => RectanglesDataSourceImpl());
  di.registerLazySingleton<AyatPositionDataSource>(() => AyatPositionDataSourceImpl());
  di.registerLazySingleton<QuranPagesInfoSource>(() => QuranPagesInfoSourceImpl());
  di.registerLazySingleton<PlayerDataSource>(() => PlayerDataSourceImpl(readersPrefsDataSource: di(), repeatDataSource: di()));
  di.registerLazySingleton<FahresDataSource>(() => FahresLocalDataSource());
  di.registerLazySingleton(() => SharedPreferences.getInstance().then((value) => value));

  di.registerLazySingleton(() => GetFirstAyaInPageUsecase(fahresRepo: di()));

  final myAudioManager = await initAudioService();
  di.registerLazySingleton<MyAudioManager>(() => myAudioManager);

  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
