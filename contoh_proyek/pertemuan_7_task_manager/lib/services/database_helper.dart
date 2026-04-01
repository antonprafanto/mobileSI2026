import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  static const String _dbName = 'task_manager.db';
  static const int _dbVersion = 1;
  static const String tableTasks = 'tasks';

  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colIsCompleted = 'isCompleted';
  static const String colCreatedAt = 'createdAt';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableTasks (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT NOT NULL,
        $colDescription TEXT,
        $colIsCompleted INTEGER DEFAULT 0,
        $colCreatedAt TEXT
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(tableTasks, task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final maps = await db.query(tableTasks, orderBy: '$colCreatedAt DESC');
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<List<Task>> searchTasks(String query) async {
    final db = await database;
    final maps = await db.query(
      tableTasks,
      where: '$colTitle LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: '$colCreatedAt DESC',
    );
    return maps.map((m) => Task.fromMap(m)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      tableTasks,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(tableTasks, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete(tableTasks);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
