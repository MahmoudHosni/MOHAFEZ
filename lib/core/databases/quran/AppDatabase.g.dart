// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AyaDao? _ayaDaoInstance;

  SoraDao? _soraDaoInstance;

  JuzaDao? _juzaDaoInstance;

  NoteDao? _noteDaoInstance;

  QuarterDao? _quarterDaoInstance;

  FavouriteDao? _favouriteDaoInstance;

  BookmarkDao? _bookmarkDaoInstance;

  QuranPagesInfoDao? _quranPagesInfoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Quran` (`ID` INTEGER NOT NULL, `SoraNum` INTEGER NOT NULL, `AyaNum` INTEGER NOT NULL, `PageNum` INTEGER NOT NULL, `PartNum` INTEGER NOT NULL, `sign_type` INTEGER NOT NULL, `search_text` TEXT NOT NULL, `SoraName` TEXT NOT NULL, `SoraName_en` TEXT NOT NULL, `AyaDiac` TEXT NOT NULL, `AyaNoDiac` TEXT NOT NULL, `trans_en` TEXT NOT NULL, PRIMARY KEY (`ID`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sora` (`Id` INTEGER NOT NULL, `Name` TEXT NOT NULL, `AyatCount` INTEGER NOT NULL, `PageNum` INTEGER NOT NULL, `Type` INTEGER NOT NULL, `SearchText` TEXT NOT NULL, `name_ar` TEXT NOT NULL, `name_en` TEXT NOT NULL, `start_aya` INTEGER NOT NULL, `end_aya` INTEGER NOT NULL, PRIMARY KEY (`Id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Juza` (`JID` INTEGER NOT NULL, `JuzaName` TEXT NOT NULL, `JuzaNum` TEXT NOT NULL, `PageNo` INTEGER NOT NULL, `AyaNo` INTEGER NOT NULL, `name_en` TEXT NOT NULL, `end_aya` INTEGER NOT NULL, PRIMARY KEY (`JID`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`ID` INTEGER PRIMARY KEY AUTOINCREMENT, `note_txt` TEXT NOT NULL, `aya_ID` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Favourite` (`ID` INTEGER PRIMARY KEY AUTOINCREMENT, `aya_ID` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Bookmarks` (`ID` INTEGER PRIMARY KEY AUTOINCREMENT, `aya_ID` INTEGER NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HashTags` (`ID` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `ayaID` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuranPagesInfo` (`PageNum` INTEGER NOT NULL, `PartNum` INTEGER NOT NULL, `HezbNum` INTEGER NOT NULL, `RubNum` INTEGER NOT NULL, PRIMARY KEY (`PageNum`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Quarter` (`Id` INTEGER NOT NULL, `Part` INTEGER NOT NULL, `Hezb` INTEGER NOT NULL, `AyaId` INTEGER NOT NULL, `Quarter` INTEGER NOT NULL, PRIMARY KEY (`Id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AyaDao get ayaDao {
    return _ayaDaoInstance ??= _$AyaDao(database, changeListener);
  }

  @override
  SoraDao get soraDao {
    return _soraDaoInstance ??= _$SoraDao(database, changeListener);
  }

  @override
  JuzaDao get juzaDao {
    return _juzaDaoInstance ??= _$JuzaDao(database, changeListener);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  QuarterDao get quarterDao {
    return _quarterDaoInstance ??= _$QuarterDao(database, changeListener);
  }

  @override
  FavouriteDao get favouriteDao {
    return _favouriteDaoInstance ??= _$FavouriteDao(database, changeListener);
  }

  @override
  BookmarkDao get bookmarkDao {
    return _bookmarkDaoInstance ??= _$BookmarkDao(database, changeListener);
  }

  @override
  QuranPagesInfoDao get quranPagesInfoDao {
    return _quranPagesInfoDaoInstance ??=
        _$QuranPagesInfoDao(database, changeListener);
  }
}

class _$AyaDao extends AyaDao {
  _$AyaDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Quran>> getAyatInRange(
    int sora,
    int staya,
    int endaya,
  ) async {
    return _queryAdapter.queryList(
        'select * FROM Quran WHERE AyaNum between ?2 and ?3 and SoraNum=?1',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [sora, staya, endaya]);
  }

  @override
  Future<List<Quran>> getAyat(
    int staya,
    int endaya,
  ) async {
    return _queryAdapter.queryList(
        'select * FROM Quran WHERE ID between ?1 and ?2',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [staya, endaya]);
  }

  @override
  Future<Quran?> getAyaByID(int ayaID) async {
    return _queryAdapter.query('select * FROM Quran WHERE ID=?1',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [ayaID]);
  }

  @override
  Future<List<Quran?>> getAyatByID(
    int startAyaID,
    int endAyaID,
  ) async {
    return _queryAdapter.queryList(
        'select * FROM Quran WHERE ID between ?1 and ?2',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [startAyaID, endAyaID]);
  }

  @override
  Future<Quran?> getAyaOf(
    int ayaNum,
    int soraNum,
  ) async {
    return _queryAdapter.query(
        'select * FROM Quran WHERE AyaNum=?1 and SoraNum=?2',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [ayaNum, soraNum]);
  }

  @override
  Future<List<Quran>> getAyatInPage(int page) async {
    return _queryAdapter.queryList('select * from Quran where PageNum=?1',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [page]);
  }

  @override
  Future<List<Quran>> searchAyat(String word) async {
    return _queryAdapter.queryList(
        'select * FROM Quran WHERE AyaNoDiac like ?1',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [word]);
  }

  @override
  Future<List<Quran>> getAyatByIDS(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM Quran WHERE ID IN (' +
            _sqliteVariablesForIds +
            ')  ORDER BY ID;',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [...ids]);
  }

  @override
  Future<List<Quran>> getFavouriteAyat() async {
    return _queryAdapter.queryList(
        'select * from Quran where ID in (select aya_ID from favourite)',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String));
  }

  @override
  Future<List<Quran>> getBookmarkAyat() async {
    return _queryAdapter.queryList(
        'select * from Quran where ID in (select aya_ID from bookmark)',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String));
  }

  @override
  Future<List<Quran>> searchForAyat(
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
  ) async {
    return _queryAdapter.queryList(
        'SELECT distinct ID, SoraNum, AyaNum, PageNum, SoraName, SoraName_en, AyaDiac, AyaNoDiac, search_text, PartNum, trans_en, sign_type FROM Quran WHERE ( search_text like ?1 OR search_text like ?2 OR search_text like ?3 OR search_text like ?4 OR search_text like ?5 OR search_text like ?6 );',
        mapper: (Map<String, Object?> row) => Quran(row['ID'] as int, row['PageNum'] as int, row['AyaDiac'] as String, row['AyaNoDiac'] as String, row['AyaNum'] as int, row['PartNum'] as int, row['search_text'] as String, row['sign_type'] as int, row['SoraName'] as String, row['SoraName_en'] as String, row['SoraNum'] as int, row['trans_en'] as String),
        arguments: [text1, text2, text3, text4, text5, text6]);
  }

  @override
  Future<Quran?> getFirstAyaFor(int quarterId) async {
    return _queryAdapter.query(
        'select * from Quran where ID = (select AyaId from Quarter where Id = ?1)',
        mapper: (Map<String, Object?> row) => Quran(row['ID'] as int, row['PageNum'] as int, row['AyaDiac'] as String, row['AyaNoDiac'] as String, row['AyaNum'] as int, row['PartNum'] as int, row['search_text'] as String, row['sign_type'] as int, row['SoraName'] as String, row['SoraName_en'] as String, row['SoraNum'] as int, row['trans_en'] as String),
        arguments: [quarterId]);
  }

  @override
  Future<Quran?> getLastAyaFor(int quarterId) async {
    return _queryAdapter.query(
        'select * from Quran where ID = (select AyaId from Quarter where Id = ?1) - 1',
        mapper: (Map<String, Object?> row) => Quran(row['ID'] as int, row['PageNum'] as int, row['AyaDiac'] as String, row['AyaNoDiac'] as String, row['AyaNum'] as int, row['PartNum'] as int, row['search_text'] as String, row['sign_type'] as int, row['SoraName'] as String, row['SoraName_en'] as String, row['SoraNum'] as int, row['trans_en'] as String),
        arguments: [quarterId]);
  }

  @override
  Future<Quran?> getLastAyaInQuran() async {
    return _queryAdapter.query('select * from Quran where ID = 6236',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String));
  }

  @override
  Future<Quran?> getFirstAyaInPart(int part) async {
    return _queryAdapter.query(
        'select * from Quran where PartNum=?1 ORDER by ID ASC limit 1',
        mapper: (Map<String, Object?> row) => Quran(
            row['ID'] as int,
            row['PageNum'] as int,
            row['AyaDiac'] as String,
            row['AyaNoDiac'] as String,
            row['AyaNum'] as int,
            row['PartNum'] as int,
            row['search_text'] as String,
            row['sign_type'] as int,
            row['SoraName'] as String,
            row['SoraName_en'] as String,
            row['SoraNum'] as int,
            row['trans_en'] as String),
        arguments: [part]);
  }
}

class _$SoraDao extends SoraDao {
  _$SoraDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Sora>> getAllSoras() async {
    return _queryAdapter.queryList('select * from Sora',
        mapper: (Map<String, Object?> row) => Sora(
            row['Id'] as int,
            row['Name'] as String,
            row['AyatCount'] as int,
            row['PageNum'] as int,
            row['Type'] as int,
            row['SearchText'] as String,
            row['name_ar'] as String,
            row['name_en'] as String,
            row['start_aya'] as int,
            row['end_aya'] as int));
  }

  @override
  Future<List<Sora>> getAllSorasAsFuture() async {
    return _queryAdapter.queryList('select * from Sora',
        mapper: (Map<String, Object?> row) => Sora(
            row['Id'] as int,
            row['Name'] as String,
            row['AyatCount'] as int,
            row['PageNum'] as int,
            row['Type'] as int,
            row['SearchText'] as String,
            row['name_ar'] as String,
            row['name_en'] as String,
            row['start_aya'] as int,
            row['end_aya'] as int));
  }

  @override
  Future<Sora?> getSoraByID(int id) async {
    return _queryAdapter.query('select * from Sora where id=?1',
        mapper: (Map<String, Object?> row) => Sora(
            row['Id'] as int,
            row['Name'] as String,
            row['AyatCount'] as int,
            row['PageNum'] as int,
            row['Type'] as int,
            row['SearchText'] as String,
            row['name_ar'] as String,
            row['name_en'] as String,
            row['start_aya'] as int,
            row['end_aya'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Sora>> searchInSoras(String word) async {
    return _queryAdapter.queryList(
        'select * from Sora where SearchText like ?1',
        mapper: (Map<String, Object?> row) => Sora(
            row['Id'] as int,
            row['Name'] as String,
            row['AyatCount'] as int,
            row['PageNum'] as int,
            row['Type'] as int,
            row['SearchText'] as String,
            row['name_ar'] as String,
            row['name_en'] as String,
            row['start_aya'] as int,
            row['end_aya'] as int),
        arguments: [word]);
  }

  @override
  Future<List<Sora>> searchForSour(
    String text1,
    String text2,
    String text3,
    String text4,
    String text5,
    String text6,
  ) async {
    return _queryAdapter.queryList(
        'SELECT distinct Id, Name, name_ar, AyatCount, PageNum, SearchText, name_en, Type, start_aya, end_aya FROM Sora WHERE ( SearchText like ?1 OR SearchText like ?2 OR SearchText like ?3 OR SearchText like ?4 OR SearchText like ?5 OR SearchText like ?6 OR name_en like ?1 OR name_en like ?2 OR name_en like ?3 OR name_en like ?4 OR name_en like ?5 OR name_en like ?6);',
        mapper: (Map<String, Object?> row) => Sora(row['Id'] as int, row['Name'] as String, row['AyatCount'] as int, row['PageNum'] as int, row['Type'] as int, row['SearchText'] as String, row['name_ar'] as String, row['name_en'] as String, row['start_aya'] as int, row['end_aya'] as int),
        arguments: [text1, text2, text3, text4, text5, text6]);
  }
}

class _$JuzaDao extends JuzaDao {
  _$JuzaDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<Juza>> getAllAjza() async {
    return _queryAdapter.queryList('select * from Juza',
        mapper: (Map<String, Object?> row) => Juza(
            JID: row['JID'] as int,
            JuzaName: row['JuzaName'] as String,
            JuzaNum: row['JuzaNum'] as String,
            PageNo: row['PageNo'] as int,
            AyaNo: row['AyaNo'] as int,
            name_en: row['name_en'] as String,
            end_aya: row['end_aya'] as int));
  }

  @override
  Future<Juza?> getJuzaByID(int id) async {
    return _queryAdapter.query('select * from Juza where JID=?1',
        mapper: (Map<String, Object?> row) => Juza(
            JID: row['JID'] as int,
            JuzaName: row['JuzaName'] as String,
            JuzaNum: row['JuzaNum'] as String,
            PageNo: row['PageNo'] as int,
            AyaNo: row['AyaNo'] as int,
            name_en: row['name_en'] as String,
            end_aya: row['end_aya'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Juza>> searchInAjza(String word) async {
    return _queryAdapter.queryList(
        'select * from Juza where SearchText like ?1',
        mapper: (Map<String, Object?> row) => Juza(
            JID: row['JID'] as int,
            JuzaName: row['JuzaName'] as String,
            JuzaNum: row['JuzaNum'] as String,
            PageNo: row['PageNo'] as int,
            AyaNo: row['AyaNo'] as int,
            name_en: row['name_en'] as String,
            end_aya: row['end_aya'] as int),
        arguments: [word]);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, Object?>{
                  'ID': item.ID,
                  'note_txt': item.note_txt,
                  'aya_ID': item.aya_ID
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['ID'],
            (Note item) => <String, Object?>{
                  'ID': item.ID,
                  'note_txt': item.note_txt,
                  'aya_ID': item.aya_ID
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  @override
  Future<List<Note>> getNotes() async {
    return _queryAdapter.queryList('select * from note',
        mapper: (Map<String, Object?> row) => Note(
            ID: row['ID'] as int?,
            note_txt: row['note_txt'] as String,
            aya_ID: row['aya_ID'] as int));
  }

  @override
  Future<void> deleteNote(int ayaID) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM note WHERE aya_ID=?1', arguments: [ayaID]);
  }

  @override
  Future<Note?> isNoteExist(int ayaID) async {
    return _queryAdapter.query('select * from note where aya_ID=?1',
        mapper: (Map<String, Object?> row) => Note(
            ID: row['ID'] as int?,
            note_txt: row['note_txt'] as String,
            aya_ID: row['aya_ID'] as int),
        arguments: [ayaID]);
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.replace);
  }
}

class _$QuarterDao extends QuarterDao {
  _$QuarterDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<MQuarter>> GetAllQuarters() async {
    return _queryAdapter.queryList('SELECT * from  Quarter',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int));
  }

  @override
  Future<List<MQuarter>> getQuartersByPartNo(int part) async {
    return _queryAdapter.queryList('select * from Quarter where Part =?1',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int),
        arguments: [part]);
  }

  @override
  Future<List<MQuarter>> getQuartersByHezpNo(int hezp) async {
    return _queryAdapter.queryList('select * from Quarter where Hezb =?1',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int),
        arguments: [hezp]);
  }

  @override
  Future<List<MQuarter>> getQuartersByQuarterNo(int quarter) async {
    return _queryAdapter.queryList('select * from Quarter where Quarter =?1',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int),
        arguments: [quarter]);
  }

  @override
  Future<List<MQuarter>> getQuarterByAyaId(int ayaId) async {
    return _queryAdapter.queryList('select * from Quarter where AyaId =?1',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int),
        arguments: [ayaId]);
  }

  @override
  Future<List<MQuarter>> getAllAjza() async {
    return _queryAdapter.queryList(
        'SELECT Quarter.Id,(Quarter.Part),Quarter.Hezb,Quarter.Quarter,Quarter.AyaId from Quarter where Quarter.Part in (SELECT DISTINCT(Quarter.Part) from Quarter) and Quarter.Hezb % 2=1 and Quarter.Quarter=1',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int));
  }

  @override
  Future<MQuarter?> getQuarterById(int quarterNo) async {
    return _queryAdapter.query('select * from Quarter where Quarter.Id = ?1',
        mapper: (Map<String, Object?> row) => MQuarter(
            Id: row['Id'] as int,
            Part: row['Part'] as int,
            Hezb: row['Hezb'] as int,
            AyaId: row['AyaId'] as int,
            Quarter: row['Quarter'] as int),
        arguments: [quarterNo]);
  }
}

class _$FavouriteDao extends FavouriteDao {
  _$FavouriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favouriteInsertionAdapter = InsertionAdapter(
            database,
            'Favourite',
            (Favourite item) =>
                <String, Object?>{'ID': item.ID, 'aya_ID': item.aya_ID}),
        _favouriteUpdateAdapter = UpdateAdapter(
            database,
            'Favourite',
            ['ID'],
            (Favourite item) =>
                <String, Object?>{'ID': item.ID, 'aya_ID': item.aya_ID}),
        _favouriteDeletionAdapter = DeletionAdapter(
            database,
            'Favourite',
            ['ID'],
            (Favourite item) =>
                <String, Object?>{'ID': item.ID, 'aya_ID': item.aya_ID});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Favourite> _favouriteInsertionAdapter;

  final UpdateAdapter<Favourite> _favouriteUpdateAdapter;

  final DeletionAdapter<Favourite> _favouriteDeletionAdapter;

  @override
  Future<List<Favourite>> getFavourites() async {
    return _queryAdapter.queryList('select * from favourite',
        mapper: (Map<String, Object?> row) =>
            Favourite(ID: row['ID'] as int?, aya_ID: row['aya_ID'] as int));
  }

  @override
  Future<Favourite?> isFavouriteExist(int ayaID) async {
    return _queryAdapter.query('select * from favourite where aya_ID=?1',
        mapper: (Map<String, Object?> row) =>
            Favourite(ID: row['ID'] as int?, aya_ID: row['aya_ID'] as int),
        arguments: [ayaID]);
  }

  @override
  Future<void> insertFavourite(Favourite favourite) async {
    await _favouriteInsertionAdapter.insert(
        favourite, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateFavourite(Favourite favourite) async {
    await _favouriteUpdateAdapter.update(favourite, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFavourite(Favourite favourite) async {
    await _favouriteDeletionAdapter.delete(favourite);
  }
}

class _$BookmarkDao extends BookmarkDao {
  _$BookmarkDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookmarksInsertionAdapter = InsertionAdapter(
            database,
            'Bookmarks',
            (Bookmarks item) => <String, Object?>{
                  'ID': item.ID,
                  'aya_ID': item.aya_ID,
                  'name': item.name,
                  'type': item.type
                }),
        _bookmarksUpdateAdapter = UpdateAdapter(
            database,
            'Bookmarks',
            ['ID'],
            (Bookmarks item) => <String, Object?>{
                  'ID': item.ID,
                  'aya_ID': item.aya_ID,
                  'name': item.name,
                  'type': item.type
                }),
        _bookmarksDeletionAdapter = DeletionAdapter(
            database,
            'Bookmarks',
            ['ID'],
            (Bookmarks item) => <String, Object?>{
                  'ID': item.ID,
                  'aya_ID': item.aya_ID,
                  'name': item.name,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Bookmarks> _bookmarksInsertionAdapter;

  final UpdateAdapter<Bookmarks> _bookmarksUpdateAdapter;

  final DeletionAdapter<Bookmarks> _bookmarksDeletionAdapter;

  @override
  Future<List<Bookmarks>> getBookmarks(String type) async {
    return _queryAdapter.queryList('select * from bookmarks where type=?1',
        mapper: (Map<String, Object?> row) => Bookmarks(
            ID: row['ID'] as int?,
            aya_ID: row['aya_ID'] as int,
            name: row['name'] as String,
            type: row['type'] as String),
        arguments: [type]);
  }

  @override
  Future<List<Bookmarks>> getAllBookmarks() async {
    return _queryAdapter.queryList('select * from bookmarks',
        mapper: (Map<String, Object?> row) => Bookmarks(
            ID: row['ID'] as int?,
            aya_ID: row['aya_ID'] as int,
            name: row['name'] as String,
            type: row['type'] as String));
  }

  @override
  Future<Bookmarks?> isBookamrkExist(int ayaID) async {
    return _queryAdapter.query('select * from bookmarks where aya_ID=?1',
        mapper: (Map<String, Object?> row) => Bookmarks(
            ID: row['ID'] as int?,
            aya_ID: row['aya_ID'] as int,
            name: row['name'] as String,
            type: row['type'] as String),
        arguments: [ayaID]);
  }

  @override
  Future<void> insertBookmark(Bookmarks bookmark) async {
    await _bookmarksInsertionAdapter.insert(
        bookmark, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateBookmark(Bookmarks bookmark) async {
    await _bookmarksUpdateAdapter.update(bookmark, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBookmark(Bookmarks bookmark) async {
    await _bookmarksDeletionAdapter.delete(bookmark);
  }
}

class _$QuranPagesInfoDao extends QuranPagesInfoDao {
  _$QuranPagesInfoDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<QuranPagesInfo?> getPageInfo(int no) async {
    return _queryAdapter.query('select * from QuranPagesInfo where PageNum=?1',
        mapper: (Map<String, Object?> row) => QuranPagesInfo(
            PageNum: row['PageNum'] as int,
            PartNum: row['PartNum'] as int,
            HezbNum: row['HezbNum'] as int,
            RubNum: row['RubNum'] as int),
        arguments: [no]);
  }
}
