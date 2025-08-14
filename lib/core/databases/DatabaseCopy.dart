import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/Constants.dart';

class DatabaseCopy {
  Future<Database> copyDBs() async{
    Future<Database> result;
    result=getDB('quran_data1.db');
    result=getDB('Ayatpositions1New.db');
    result=getDB('rectangles1New.db');
    result=getDBWthFolderName('Tafser',Constants.MoyserDB+".db");

    result=getDB('Ayat_1.db');
    result=getDB('Ayat_2.db');
    result=getDB('Ayat_3.db');
    result=getDB('Ayat_4.db');
    result=getDB('Ayat_5.db');
    result=getDB('Ayat_6.db');
    result=getDB('Ayat_7.db');
    result=getDB('Ayat_8.db');
    result=getDB('Ayat_9.db');
    result=getDB('Ayat_10.db');
    result=getDB('Ayat_11.db');
    result=getDB('Ayat_12.db');
    result=getDB('Ayat_13.db');
    result=getDB('Ayat_14.db');
    result=getDB('Ayat_15.db');

    result=getDB('Ayat_16.db');
    result=getDB('Ayat_17.db');
    result=getDB('Ayat_18.db');
    result=getDB('Ayat_19.db');
    result=getDB('Ayat_20.db');
    result=getDB('Ayat_21.db');
    result=getDB('Ayat_22.db');
    result=getDB('Ayat_23.db');
    result=getDB('Ayat_24.db');
    result=getDB('Ayat_25.db');
    result=getDB('Ayat_26.db');
    result=getDB('Ayat_27.db');
    result=getDB('Ayat_28.db');
    result=getDB('Ayat_29.db');
    result=getDB('Ayat_30.db');
    result=getDB('Ayat_31.db');
    result = getDB("languages1.db");
    result = getDB("QuranFont.db");
    return result;
  }

  Future<Database> getDB(String name) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, name);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
      }

      var data = await rootBundle.load(join('assets', name));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future<Database> getDBWthFolderName(String foldername,String name) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, foldername + '/' + name);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
      }

      var data = await rootBundle.load(join('assets',name));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }
}