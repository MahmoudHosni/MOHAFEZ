import 'package:floor/floor.dart';
import '../../../entity/aya_rect/ExportLine.dart';

@dao
abstract class ExportLineDao{
    @Query("select * from ExportLine where X<=:xpos and XMax>=:xpos and PageNo=:page and LineNum=:line ")//@Query("select * from ExportLine where X<=:xpos and XMax>=:xpos and Y<=:ypos and YMax>=:ypos and PageNo=:page and LineNum=:line ")
    Future<List<ExportLine>> getRectanglesFromEvent(double xpos,int page,int line);

    @Query("select * from ExportLine where X<:xpos and XMax>:xpos and PageNo=:page and LineNum=:line ")//@Query("select * from ExportLine where X<:xpos and XMax>:xpos and Y<:ypos and YMax>:ypos and PageNo=:page and LineNum=:line ")
    Future<List<ExportLine>> getRectanglesFromEventLandscape(double xpos,int page,int line);

    @Query("Select * from ExportLine where AyaNum=:ayaNo and SoraID=:sId")
    Future<List<ExportLine>> getRectanglesForAya(int ayaNo,int sId);

    
}