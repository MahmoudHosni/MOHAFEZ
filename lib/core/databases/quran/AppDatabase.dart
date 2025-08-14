import 'dart:async';

import '../../entity/quran/Quarter.dart';
import '../../entity/quran/Quran.dart';
import '../../entity/quran/QuranPagesInfo.dart';
import '../../entity/quran/Juza.dart';
import '../../entity/quran/Sora.dart';
import '../../entity/user/Bookmarks.dart';
import '../../entity/user/Favourite.dart';
import '../../entity/user/HashTags.dart';
import '../../entity/user/Note.dart';
import '../dao/quran/AyaDao.dart';
import '../dao/quran/JuzaDao.dart';
import '../dao/quran/QuarterDao.dart';
import '../dao/quran/QuranPagesInfoDao.dart';
import '../dao/quran/SoraDao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../dao/user/BookmarkDao.dart';
import '../dao/user/FavouriteDao.dart';
import '../dao/user/NoteDao.dart';

part 'AppDatabase.g.dart';

@Database(version: 1, entities: [Quran,Sora,Juza,Note,Favourite,Bookmarks,HashTags,QuranPagesInfo,MQuarter],)
abstract class AppDatabase extends FloorDatabase{
  AyaDao  get ayaDao;
  SoraDao get soraDao;
  JuzaDao get juzaDao;
  NoteDao get noteDao;
  QuarterDao get quarterDao;
  FavouriteDao get favouriteDao;
  BookmarkDao get bookmarkDao;
  QuranPagesInfoDao get quranPagesInfoDao;
}