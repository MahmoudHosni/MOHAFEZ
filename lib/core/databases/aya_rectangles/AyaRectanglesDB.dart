import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../entity/aya_rect/ExportLine.dart';
import '../dao/aya_rectangles/ExportLineDao.dart';

part 'AyaRectanglesDB.g.dart';

@Database(version: 1, entities: [ExportLine])
abstract class AyaRectanglesDB  extends FloorDatabase{
  ExportLineDao get exportLineDao;
}