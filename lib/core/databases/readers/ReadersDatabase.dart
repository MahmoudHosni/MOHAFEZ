import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../entity/player/ReaderAya.dart';
import '../dao/reader/ReaderDao.dart';

part 'ReadersDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ZAYA])
abstract class ReadersDatabase extends FloorDatabase{
  ReaderDao get readerDao;
}