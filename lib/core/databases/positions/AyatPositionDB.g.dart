// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AyatPositionDB.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AyatPositionDBBuilderContract {
  /// Adds migrations to the builder.
  $AyatPositionDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AyatPositionDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AyatPositionDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAyatPositionDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AyatPositionDBBuilderContract databaseBuilder(String name) =>
      _$AyatPositionDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AyatPositionDBBuilderContract inMemoryDatabaseBuilder() =>
      _$AyatPositionDBBuilder(null);
}

class _$AyatPositionDBBuilder implements $AyatPositionDBBuilderContract {
  _$AyatPositionDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AyatPositionDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AyatPositionDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AyatPositionDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AyatPositionDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AyatPositionDB extends AyatPositionDB {
  _$AyatPositionDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AyaPositionDao? _ayaPositionDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `AyaNumPositions` (`AyaID` INTEGER NOT NULL, `AyaNum` INTEGER NOT NULL, `SoraID` INTEGER NOT NULL, `PageNo` INTEGER NOT NULL, `X` INTEGER, `Y` INTEGER, `XMax` INTEGER, `YMax` INTEGER, `MatchRatio` REAL, `LineNum` INTEGER, PRIMARY KEY (`AyaID`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AyaPositionDao get ayaPositionDao {
    return _ayaPositionDaoInstance ??=
        _$AyaPositionDao(database, changeListener);
  }
}

class _$AyaPositionDao extends AyaPositionDao {
  _$AyaPositionDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<AyaNumPositions>> getAyatPositionsInPage(int page) async {
    return _queryAdapter.queryList(
        'select * from AyaNumPositions where PageNo=?1',
        mapper: (Map<String, Object?> row) => AyaNumPositions(
            row['AyaID'] as int,
            row['AyaNum'] as int,
            row['SoraID'] as int,
            row['PageNo'] as int,
            row['X'] as int?,
            row['Y'] as int?,
            row['XMax'] as int?,
            row['YMax'] as int?,
            row['MatchRatio'] as double?,
            row['LineNum'] as int?),
        arguments: [page]);
  }

  @override
  Future<List<AyaNumPositions>> getAyatPositionsInRange(
    int minpage,
    int maxpage,
  ) async {
    return _queryAdapter.queryList(
        'select * from AyaNumPositions where PageNo>?1 and PageNo<?2',
        mapper: (Map<String, Object?> row) => AyaNumPositions(
            row['AyaID'] as int,
            row['AyaNum'] as int,
            row['SoraID'] as int,
            row['PageNo'] as int,
            row['X'] as int?,
            row['Y'] as int?,
            row['XMax'] as int?,
            row['YMax'] as int?,
            row['MatchRatio'] as double?,
            row['LineNum'] as int?),
        arguments: [minpage, maxpage]);
  }
}
