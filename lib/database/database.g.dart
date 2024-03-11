// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  PokeDao? _pokeDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `poke` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `height` INTEGER NOT NULL, `weight` INTEGER NOT NULL, `ability` TEXT NOT NULL, `order` INTEGER NOT NULL, `urlDefaultImage` TEXT NOT NULL, `urlSecondImage` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokeDao get pokeDao {
    return _pokeDaoInstance ??= _$PokeDao(database, changeListener);
  }
}

class _$PokeDao extends PokeDao {
  _$PokeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _pokeInsertionAdapter = InsertionAdapter(
            database,
            'poke',
            (Poke item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'height': item.height,
                  'weight': item.weight,
                  'ability': item.ability,
                  'order': item.order,
                  'urlDefaultImage': item.urlDefaultImage,
                  'urlSecondImage': item.urlSecondImage
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Poke> _pokeInsertionAdapter;

  @override
  Future<List<Poke>> findAllPoke() async {
    return _queryAdapter.queryList('SELECT * FROM Poke',
        mapper: (Map<String, Object?> row) => Poke(
            row['id'] as int,
            row['name'] as String,
            row['height'] as int,
            row['weight'] as int,
            row['ability'] as String,
            row['order'] as int,
            row['urlDefaultImage'] as String,
            row['urlSecondImage'] as String));
  }

  @override
  Stream<List<String>> findAllPokeName() {
    return _queryAdapter.queryListStream('SELECT name FROM Poke',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Poke',
        isView: false);
  }

  @override
  Stream<Poke?> findPokeById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Poke WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Poke(
            row['id'] as int,
            row['name'] as String,
            row['height'] as int,
            row['weight'] as int,
            row['ability'] as String,
            row['order'] as int,
            row['urlDefaultImage'] as String,
            row['urlSecondImage'] as String),
        arguments: [id],
        queryableName: 'Poke',
        isView: false);
  }

  @override
  Future<void> deletePokeById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Poke WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertPoke(Poke poke) async {
    await _pokeInsertionAdapter.insert(poke, OnConflictStrategy.abort);
  }
}
