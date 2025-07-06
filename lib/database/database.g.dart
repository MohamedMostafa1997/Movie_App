// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $MovieDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $MovieDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $MovieDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<MovieDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorMovieDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MovieDatabaseBuilderContract databaseBuilder(String name) =>
      _$MovieDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MovieDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$MovieDatabaseBuilder(null);
}

class _$MovieDatabaseBuilder implements $MovieDatabaseBuilderContract {
  _$MovieDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $MovieDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $MovieDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<MovieDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieDatabase extends MovieDatabase {
  _$MovieDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `poster` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'poster': item.poster
                },
            changeListener),
        _movieUpdateAdapter = UpdateAdapter(
            database,
            'Movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'poster': item.poster
                },
            changeListener),
        _movieDeletionAdapter = DeletionAdapter(
            database,
            'Movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'poster': item.poster
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final UpdateAdapter<Movie> _movieUpdateAdapter;

  final DeletionAdapter<Movie> _movieDeletionAdapter;

  @override
  Stream<List<Movie>> getAllMovie() {
    return _queryAdapter.queryListStream('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int?,
            title: row['title'] as String,
            poster: row['poster'] as String),
        queryableName: 'Movie',
        isView: false);
  }

  @override
  Future<Movie?> getMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM Movie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int?,
            title: row['title'] as String,
            poster: row['poster'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllMovies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Movie');
  }

  @override
  Future<void> insertMovie(Movie moive) async {
    await _movieInsertionAdapter.insert(moive, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMovie(Movie moive) async {
    await _movieUpdateAdapter.update(moive, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(Movie moive) async {
    await _movieDeletionAdapter.delete(moive);
  }
}
