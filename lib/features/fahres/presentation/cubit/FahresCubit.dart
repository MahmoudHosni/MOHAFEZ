import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entity/quran/Juza.dart';
import '../../../../core/entity/quran/Quarter.dart';
import '../../../../core/entity/quran/Sora.dart';
import '../../domain/use_cases/GetAjuzaWithQuarters.dart';
import '../../domain/use_cases/GetAllAjzaUsecase.dart';
import '../../domain/use_cases/GetAllSuras.dart';
import '../../domain/use_cases/SearchInAjzaUsecase.dart';
import '../../domain/use_cases/SearchInSorasUsecase.dart';
import 'FahresState.dart';

class FahresCubit extends Cubit<FahresState>{
  final GetAllSurasUsecase sorasUsecase;
  final GetAllAjzaUsecase allAjzaUsecase;
  final SearchInSorasUsecase searchInSorasUsecase;
  final SearchInAjzaUsecase searchInAjzaUsecase;
  final GetAjuzaWithQuarters getAjuzaWithQuarters;

  static FahresCubit get(context)=>BlocProvider.of(context);

  FahresCubit({required this.allAjzaUsecase,required this.sorasUsecase,
    required this.searchInAjzaUsecase,required this.searchInSorasUsecase,required this.getAjuzaWithQuarters,}):super(LoadingFahresState());

  Future<List<Juza>> getAjza(){
    return allAjzaUsecase.call();
  }

  Future<List<Sora>> getSoras(){
    return sorasUsecase.call();
  }

  Future<List<Sora>> searchInSoras(String word){
    return searchInSorasUsecase.call(word);
  }

  Future<List<Juza>> searchInAjza(String word){
    return searchInAjzaUsecase.call(word);
  }

  Future<List<MQuarter>> getAllAjuzaWithQuarters() {
    return getAjuzaWithQuarters.call();
  }
}