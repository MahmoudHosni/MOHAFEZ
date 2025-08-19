import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCopy {
  Future<Database> copyDBs() async{
    Future<Database> result;
    result=getDB('db/quran_data1.db');
    result=getDB('db/rectangles1New.db');
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