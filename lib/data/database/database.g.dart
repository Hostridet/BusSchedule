// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BusDao? _busDaoInstance;

  BusTypeDao? _busTypeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `Bus` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `number` TEXT NOT NULL, `classes` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BusType` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `type` TEXT NOT NULL, `range` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BusDao get busDao {
    return _busDaoInstance ??= _$BusDao(database, changeListener);
  }

  @override
  BusTypeDao get busTypeDao {
    return _busTypeDaoInstance ??= _$BusTypeDao(database, changeListener);
  }
}

class _$BusDao extends BusDao {
  _$BusDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _busInsertionAdapter = InsertionAdapter(
            database,
            'Bus',
            (Bus item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'classes': item.classes
                },
            changeListener),
        _busUpdateAdapter = UpdateAdapter(
            database,
            'Bus',
            ['id'],
            (Bus item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'classes': item.classes
                },
            changeListener),
        _busDeletionAdapter = DeletionAdapter(
            database,
            'Bus',
            ['id'],
            (Bus item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'classes': item.classes
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Bus> _busInsertionAdapter;

  final UpdateAdapter<Bus> _busUpdateAdapter;

  final DeletionAdapter<Bus> _busDeletionAdapter;

  @override
  Stream<List<Bus>> getAllBus() {
    return _queryAdapter.queryListStream('SELECT * FROM Bus',
        mapper: (Map<String, Object?> row) => Bus(
            id: row['id'] as int,
            number: row['number'] as String,
            classes: row['classes'] as String),
        queryableName: 'Bus',
        isView: false);
  }

  @override
  Stream<Bus?> getBusById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Bus WHERE id=?1',
        mapper: (Map<String, Object?> row) => Bus(
            id: row['id'] as int,
            number: row['number'] as String,
            classes: row['classes'] as String),
        arguments: [id],
        queryableName: 'Bus',
        isView: false);
  }

  @override
  Future<void> insertBus(Bus bus) async {
    await _busInsertionAdapter.insert(bus, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBus(Bus bus) async {
    await _busUpdateAdapter.update(bus, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBus(Bus bus) async {
    await _busDeletionAdapter.delete(bus);
  }
}

class _$BusTypeDao extends BusTypeDao {
  _$BusTypeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _busTypeInsertionAdapter = InsertionAdapter(
            database,
            'BusType',
            (BusType item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'range': item.range
                },
            changeListener),
        _busTypeUpdateAdapter = UpdateAdapter(
            database,
            'BusType',
            ['id'],
            (BusType item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'range': item.range
                },
            changeListener),
        _busTypeDeletionAdapter = DeletionAdapter(
            database,
            'BusType',
            ['id'],
            (BusType item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'range': item.range
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BusType> _busTypeInsertionAdapter;

  final UpdateAdapter<BusType> _busTypeUpdateAdapter;

  final DeletionAdapter<BusType> _busTypeDeletionAdapter;

  @override
  Stream<List<BusType>> getAllBus() {
    return _queryAdapter.queryListStream('SELECT * FROM BusType',
        mapper: (Map<String, Object?> row) => BusType(
            id: row['id'] as int,
            type: row['type'] as String,
            range: row['range'] as int),
        queryableName: 'BusType',
        isView: false);
  }

  @override
  Stream<BusType?> getBusById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM BusType WHERE id=?1',
        mapper: (Map<String, Object?> row) => BusType(
            id: row['id'] as int,
            type: row['type'] as String,
            range: row['range'] as int),
        arguments: [id],
        queryableName: 'BusType',
        isView: false);
  }

  @override
  Future<void> insertBusType(BusType bus) async {
    await _busTypeInsertionAdapter.insert(bus, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBus(BusType bus) async {
    await _busTypeUpdateAdapter.update(bus, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBus(BusType bus) async {
    await _busTypeDeletionAdapter.delete(bus);
  }
}
