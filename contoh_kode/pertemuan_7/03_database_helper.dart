import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Demo 03: Database Helper Pattern
/// Singleton pattern untuk manage database

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Private constructor
  DatabaseHelper._init();

  // Database configuration
  static const String _dbName = 'app_database.db';
  static const int _dbVersion = 1;

  // Table names
  static const String tableTasks = 'tasks';
  static const String tableUsers = 'users';

  // Column names - Tasks
  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colIsCompleted = 'isCompleted';
  static const String colCreatedAt = 'createdAt';
  static const String colUserId = 'userId';

  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // Create tables
  Future<void> _createDB(Database db, int version) async {
    // Tasks table
    await db.execute('''
      CREATE TABLE $tableTasks (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT NOT NULL,
        $colDescription TEXT,
        $colIsCompleted INTEGER DEFAULT 0,
        $colCreatedAt TEXT,
        $colUserId INTEGER,
        FOREIGN KEY ($colUserId) REFERENCES $tableUsers($colId)
      )
    ''');

    // Users table
    await db.execute('''
      CREATE TABLE $tableUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        createdAt TEXT
      )
    ''');

    // Create index for faster queries
    await db.execute('CREATE INDEX idx_tasks_user ON $tableTasks($colUserId)');
  }

  // Handle database upgrades
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Migration for version 2
      // await db.execute('ALTER TABLE ...');
    }
  }

  // ==================== CRUD OPERATIONS ====================

  // CREATE
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  // READ ALL
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? orderBy,
  }) async {
    final db = await database;
    return await db.query(table, orderBy: orderBy);
  }

  // READ BY ID
  Future<Map<String, dynamic>?> getById(String table, int id) async {
    final db = await database;
    final results = await db.query(table, where: '$colId = ?', whereArgs: [id]);
    return results.isNotEmpty ? results.first : null;
  }

  // READ WITH WHERE
  Future<List<Map<String, dynamic>>> getWhere(
    String table,
    String where,
    List<dynamic> whereArgs, {
    String? orderBy,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  // UPDATE
  Future<int> update(String table, Map<String, dynamic> data, int id) async {
    final db = await database;
    return await db.update(table, data, where: '$colId = ?', whereArgs: [id]);
  }

  // DELETE
  Future<int> delete(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: '$colId = ?', whereArgs: [id]);
  }

  // DELETE ALL
  Future<int> deleteAll(String table) async {
    final db = await database;
    return await db.delete(table);
  }

  // RAW QUERY
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  // COUNT
  Future<int> count(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $table ${where != null ? 'WHERE $where' : ''}',
      whereArgs,
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // TRANSACTION
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return await db.transaction(action);
  }

  // BATCH OPERATIONS
  Future<void> batchInsert(
    String table,
    List<Map<String, dynamic>> dataList,
  ) async {
    final db = await database;
    final batch = db.batch();

    for (final data in dataList) {
      batch.insert(table, data);
    }

    await batch.commit(noResult: true);
  }

  // SEARCH
  Future<List<Map<String, dynamic>>> search(
    String table,
    String column,
    String query, {
    String? orderBy,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: '$column LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: orderBy,
    );
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  // Delete database file
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}

// ==================== USAGE EXAMPLES ====================

/*
void main() async {
  final db = DatabaseHelper.instance;

  // Insert
  final id = await db.insert(DatabaseHelper.tableTasks, {
    'title': 'Belajar Flutter',
    'description': 'Mempelajari SQLite',
    'isCompleted': 0,
    'createdAt': DateTime.now().toIso8601String(),
  });

  // Get all
  final tasks = await db.getAll(
    DatabaseHelper.tableTasks,
    orderBy: 'createdAt DESC',
  );

  // Update
  await db.update(DatabaseHelper.tableTasks, {
    'title': 'Belajar Flutter Lanjutan',
    'isCompleted': 1,
  }, id);

  // Delete
  await db.delete(DatabaseHelper.tableTasks, id);

  // Search
  final results = await db.search(
    DatabaseHelper.tableTasks,
    'title',
    'flutter',
  );

  // Close when done
  await db.close();
}
*/
