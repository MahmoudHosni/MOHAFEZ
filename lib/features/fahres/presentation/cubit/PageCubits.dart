import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entity/quran/Quran.dart';
import '../../domain/use_cases/GetFirstAyaInPageUsecase.dart';
import 'PagesState.dart';

class PageCubits extends Cubit<PagesState>{
  final GetFirstAyaInPageUsecase getFirstAyaInPageUsecase;

  static PageCubits get(context)=>BlocProvider.of(context);

  PageCubits({required this.getFirstAyaInPageUsecase}):super(LoadingPagesState());

  Future<List<Quran?>> getAyaOfPage(int page){
    return getFirstAyaInPageUsecase.call(page);
  }
}