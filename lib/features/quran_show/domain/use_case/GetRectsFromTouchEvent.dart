import '../../../../core/entity/aya_rect/ExportLine.dart';
import '../repo/RectanglesRepo.dart';
import 'package:flutter/material.dart';

class GetRectsFromTouchEvent{
  final RectanglesRepo rectanglesRepo;

  GetRectsFromTouchEvent({required this.rectanglesRepo});

  Future<List<ExportLine>> call(TapDownDetails pos,double scale,int page,Orientation orientation,int line){
    return rectanglesRepo.getRectsFromEvent(pos,scale,page,orientation,line);
  }
}