import 'package:flutter/cupertino.dart';
import '../../../../core/entity/aya_rect/ExportLine.dart';

abstract class RectanglesRepo{
  Future<List<ExportLine>> getRectsFromEvent(TapDownDetails pos, double scale,int page,Orientation orientation,int line);
  Future<List<ExportLine>> getRectsOfAya(int aya,int sora);
}