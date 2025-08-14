import 'package:flutter/material.dart';
import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../../domain/repo/RectanglesRepo.dart';
import '../../../../features/quran_show/data/data_sources/RectanglesDataSource.dart';

class RectanglesRepoImpl extends RectanglesRepo{
  final RectanglesDataSource rectanglesDataSource;

  RectanglesRepoImpl({required this.rectanglesDataSource});

  @override
  Future<List<ExportLine>> getRectsOfAya(int aya,int sora) {
    return rectanglesDataSource.getRectsOfAya(aya, sora);
  }

  @override
  Future<List<ExportLine>> getRectsFromEvent(TapDownDetails pos,double scale,int page,Orientation orientation,int line) {
    var rects= rectanglesDataSource.getAyatFromEvent(pos,scale,page,orientation,line);
    return rects.then((value) => getRectsOfAya(value.isNotEmpty?value[0].AyaNum:0, value.isNotEmpty?value[0].SoraID:0));
  }
}