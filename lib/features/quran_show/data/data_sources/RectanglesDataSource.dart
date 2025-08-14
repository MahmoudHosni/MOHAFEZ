import 'package:flutter/material.dart';
import '../../../../core/databases/aya_rectangles/AyaRectangleFloorDB.dart';
import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../../../../utils/Constants.dart';

abstract class RectanglesDataSource{
  Future<List<ExportLine>> getAyatFromEvent(TapDownDetails pos, double scale,int page,Orientation orientation,int line);
  Future<List<ExportLine>> getRectsOfAya(int aya,int sora);
}

class RectanglesDataSourceImpl extends RectanglesDataSource{

  @override
  Future<List<ExportLine>> getRectsOfAya(int aya,int sora) {
    return AyaRectangleFloorDB.instance.database.then((value) => value.exportLineDao.getRectanglesForAya(aya, sora));
  }

  @override
  Future<List<ExportLine>> getAyatFromEvent(TapDownDetails pos,double scale,int page,Orientation orientation,int line) {
    int x=0;
    int y=0;
    if(orientation==Orientation.portrait) {
      if(scale>0) {
        x = (pos.globalPosition.dx.toDouble() * scale).toInt();
        y = ((pos.localPosition.dy.toDouble()) * scale).toInt();
      }
    }else{
      x = (pos.globalPosition.dx.toDouble() * scale  + Constants.borderThicknessHeight * scale).toInt();
      y = ((pos.localPosition.dy.toDouble()) * scale + 20* (scale)).toInt();//(pos.localPosition.dy.toDouble()) ~/ scale + 20~/ (scale)
    }
    return AyaRectangleFloorDB.instance.database.then((db) => orientation==Orientation.portrait? db.exportLineDao.getRectanglesFromEvent(x.toDouble(), page,line):db.exportLineDao.getRectanglesFromEventLandscape(x.toDouble(), page,line));
  }
}