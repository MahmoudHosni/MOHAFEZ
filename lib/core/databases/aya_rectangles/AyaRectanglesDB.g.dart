// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AyaRectanglesDB.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AyaRectanglesDBBuilderContract {
  /// Adds migrations to the builder.
  $AyaRectanglesDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AyaRectanglesDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AyaRectanglesDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAyaRectanglesDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AyaRectanglesDBBuilderContract databaseBuilder(String name) =>
      _$AyaRectanglesDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AyaRectanglesDBBuilderContract inMemoryDatabaseBuilder() =>
      _$AyaRectanglesDBBuilder(null);
}

class _$AyaRectanglesDBBuilder implements $AyaRectanglesDBBuilderContract {
  _$AyaRectanglesDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AyaRectanglesDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AyaRectanglesDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AyaRectanglesDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AyaRectanglesDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AyaRectanglesDB extends AyaRectanglesDB {
  _$AyaRectanglesDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExportLineDao? _exportLineDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `ExportLine` (`RecID` INTEGER NOT NULL, `AyaNum` INTEGER NOT NULL, `SoraID` INTEGER NOT NULL, `PageNo` INTEGER NOT NULL, `LineNum` INTEGER NOT NULL, `X` INTEGER NOT NULL, `Y` INTEGER NOT NULL, `XMax` INTEGER NOT NULL, `YMax` INTEGER NOT NULL, PRIMARY KEY (`RecID`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExportLineDao get exportLineDao {
    return _exportLineDaoInstance ??= _$ExportLineDao(database, changeListener);
  }
}

class _$ExportLineDao extends ExportLineDao {
  _$ExportLineDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<ExportLine>> getRectanglesFromEvent(
    double xpos,
    int page,
    int line,
  ) async {
    return _queryAdapter.queryList(
        'select * from ExportLine where X<=?1 and XMax>=?1 and PageNo=?2 and LineNum=?3',
        mapper: (Map<String, Object?> row) => ExportLine(RecID: row['RecID'] as int, AyaNum: row['AyaNum'] as int, SoraID: row['SoraID'] as int, PageNo: row['PageNo'] as int, LineNum: row['LineNum'] as int, X: row['X'] as int, Y: row['Y'] as int, XMax: row['XMax'] as int, YMax: row['YMax'] as int),
        arguments: [xpos, page, line]);
  }

  @override
  Future<List<ExportLine>> getRectanglesFromEventLandscape(
    double xpos,
    int page,
    int line,
  ) async {
    return _queryAdapter.queryList(
        'select * from ExportLine where X<?1 and XMax>?1 and PageNo=?2 and LineNum=?3',
        mapper: (Map<String, Object?> row) => ExportLine(RecID: row['RecID'] as int, AyaNum: row['AyaNum'] as int, SoraID: row['SoraID'] as int, PageNo: row['PageNo'] as int, LineNum: row['LineNum'] as int, X: row['X'] as int, Y: row['Y'] as int, XMax: row['XMax'] as int, YMax: row['YMax'] as int),
        arguments: [xpos, page, line]);
  }

  @override
  Future<List<ExportLine>> getRectanglesForAya(
    int ayaNo,
    int sId,
  ) async {
    return _queryAdapter.queryList(
        'Select * from ExportLine where AyaNum=?1 and SoraID=?2',
        mapper: (Map<String, Object?> row) => ExportLine(
            RecID: row['RecID'] as int,
            AyaNum: row['AyaNum'] as int,
            SoraID: row['SoraID'] as int,
            PageNo: row['PageNo'] as int,
            LineNum: row['LineNum'] as int,
            X: row['X'] as int,
            Y: row['Y'] as int,
            XMax: row['XMax'] as int,
            YMax: row['YMax'] as int),
        arguments: [ayaNo, sId]);
  }
}
