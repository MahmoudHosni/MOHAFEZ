import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohafez/core/theme/dark_mode/cubit/theme_states.dart';
import '../utils/dark_mode_cache.dart';
import '../../../../core/di/InjectionContainer.dart' as si;


class ThemeCubit extends Cubit<ThemeStates>{
  ThemeCubit():super(InitThemeState());
  late DarkModeCache darkModeCache;
  bool isDark= false;
  String _isDarkKey= 'isDark';
  static ThemeCubit get(context)=>BlocProvider.of(context);

  Future<void> init() async {
    darkModeCache = si.di<DarkModeCache>();
    isDark=darkModeCache.getBoolean(key: _isDarkKey)??false;
    emit(ChangeThemeMode());
  }

  void changeAppTheme(){
      isDark =! isDark;
      darkModeCache.putBoolean(key: _isDarkKey, value: isDark).then((value) {
        emit(ChangeThemeMode());
      });
  }

  void changeAppThemeWithValue(bool value){
    isDark = value;
    darkModeCache.putBoolean(key: _isDarkKey, value: isDark).then((value) {
      emit(ChangeThemeMode());
    });
  }

  void changeAppThemeLIGHT(){
    if(isDark) {
      isDark = false;
      darkModeCache.putBoolean(key: _isDarkKey, value: isDark).then((value) {
        emit(ChangeThemeMode());
      });
    }
  }

  void changeAppThemeNIGHT() {
    if (!isDark) {
      isDark = true;
      darkModeCache.putBoolean(key: _isDarkKey, value: isDark).then((value) {
        emit(ChangeThemeMode());
      });
    }
  }
}