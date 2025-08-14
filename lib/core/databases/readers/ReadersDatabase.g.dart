// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReadersDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ReadersDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ReadersDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ReadersDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ReadersDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorReadersDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReadersDatabaseBuilderContract databaseBuilder(String name) =>
      _$ReadersDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReadersDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ReadersDatabaseBuilder(null);
}

class _$ReadersDatabaseBuilder implements $ReadersDatabaseBuilderContract {
  _$ReadersDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ReadersDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ReadersDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ReadersDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ReadersDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ReadersDatabase extends ReadersDatabase {
  _$ReadersDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ReaderDao? _readerDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `ZAYA` (`Z_PK` INTEGER NOT NULL, `Z_ENT` INTEGER NOT NULL, `Z_OPT` INTEGER NOT NULL, `ZAYANUM` INTEGER NOT NULL, `ZID` INTEGER NOT NULL, `ZSTARTAYA` INTEGER NOT NULL, `ZSORANUM` INTEGER NOT NULL, `ZBASMALAH` INTEGER NOT NULL, `ZFROMTIME` REAL NOT NULL, `ZTOTIME` REAL NOT NULL, `ZFILENAME` TEXT NOT NULL, PRIMARY KEY (`Z_PK`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ReaderDao get readerDao {
    return _readerDaoInstance ??= _$ReaderDao(database, changeListener);
  }
}

class _$ReaderDao extends ReaderDao {
  _$ReaderDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<ZAYA>> getSoraAyatInRange(
    int soraNum,
    int ayaFrom,
    int ayaTo,
  ) async {
    return _queryAdapter.queryList(
        'select * from ZAYA where ZSORANUM =?1 and ZAYANUM >=?2 and ZAYANUM <=?3',
        mapper: (Map<String, Object?> row) => ZAYA(Z_PK: row['Z_PK'] as int, Z_ENT: row['Z_ENT'] as int, Z_OPT: row['Z_OPT'] as int, ZAYANUM: row['ZAYANUM'] as int, ZID: row['ZID'] as int, ZSTARTAYA: row['ZSTARTAYA'] as int, ZSORANUM: row['ZSORANUM'] as int, ZBASMALAH: row['ZBASMALAH'] as int, ZFROMTIME: row['ZFROMTIME'] as double, ZTOTIME: row['ZTOTIME'] as double, ZFILENAME: row['ZFILENAME'] as String),
        arguments: [soraNum, ayaFrom, ayaTo]);
  }

  @override
  Future<List<ZAYA>> getAyaFromDuration(
    double dr,
    int soraNum,
  ) async {
    return _queryAdapter.queryList(
        'select * from ZAYA where ZSORANUM =?2 and ZFROMTIME >=?1',
        mapper: (Map<String, Object?> row) => ZAYA(
            Z_PK: row['Z_PK'] as int,
            Z_ENT: row['Z_ENT'] as int,
            Z_OPT: row['Z_OPT'] as int,
            ZAYANUM: row['ZAYANUM'] as int,
            ZID: row['ZID'] as int,
            ZSTARTAYA: row['ZSTARTAYA'] as int,
            ZSORANUM: row['ZSORANUM'] as int,
            ZBASMALAH: row['ZBASMALAH'] as int,
            ZFROMTIME: row['ZFROMTIME'] as double,
            ZTOTIME: row['ZTOTIME'] as double,
            ZFILENAME: row['ZFILENAME'] as String),
        arguments: [dr, soraNum]);
  }
}
