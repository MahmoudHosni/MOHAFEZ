import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/databases/readers/ReadersFloorDB.dart';
import '../../../../core/databases/readers/readers_prefs_data_source.dart';
import '../../../../core/entity/player/Reader.dart';
import '../../../../utils/app_util.dart';
import 'ReadersState.dart';

class ReadersCubit extends Cubit<ReadersState>{
  List<Reader> fullReadersList = [];
  List<Reader> readersList = [];
  late ReadersPrefsDataSource readersPrefsDataSource;

  ReadersCubit({required this.readersPrefsDataSource}):super(AllReadersState());

  static ReadersCubit get(context)=>BlocProvider.of(context);

  Future<void> init() async {
    fullReadersList = createReaders();
    readersList.clear();
    readersList.addAll(fullReadersList) ;
    if(!isClosed) {
      emit(ReadersInitState());
    }
  }

  Future<void> initSelectionsRciters() async {
    fullReadersList = createReaders();
    readersList.clear();
    readersList.addAll(fullReadersList.where((element) => element.hasSelection==true)) ;
  }

  searchInReaders(BuildContext context , String query){
    readersList.clear();
    if (query.isNotEmpty) {
      for (var reader in fullReadersList) {
        if(isArabicLocale(context)) {
          if(reader.name_ar.contains(query)) {
            readersList.add(reader);
          }
        }
        else if(reader.name_en.toLowerCase().contains(query.toLowerCase())) {
          readersList.add(reader);
        }
      }
    }
    else
    {
      readersList.addAll(fullReadersList) ;
    }
  }


  Future<int?> getSelectedReader() async {
    return readersPrefsDataSource.getSelectedReader();
  }

  void changeReader(int id) {
    ReadersFloorDB.instance.clear(id);
    readersPrefsDataSource.saveSelectedReader(id);
  }


}