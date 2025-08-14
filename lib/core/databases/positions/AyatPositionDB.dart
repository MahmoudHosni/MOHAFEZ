import 'dart:async';

import 'package:floor/floor.dart';
import '../../entity/aya_position/AyaNumPosition.dart';
import '../dao/ayatpositions/AyaPositionDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'AyatPositionDB.g.dart';

@Database(version: 1, entities: [AyaNumPositions])
abstract class AyatPositionDB  extends FloorDatabase{
  AyaPositionDao get ayaPositionDao;
}