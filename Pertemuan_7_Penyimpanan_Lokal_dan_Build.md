# 📱 PERTEMUAN 7

## Penyimpanan Lokal, Build APK & Project Akhir

---

## 🎯 Tujuan Pembelajaran

Setelah mengikuti pertemuan ini, Anda diharapkan mampu:

1. ✅ Memahami konsep penyimpanan lokal di Flutter
2. ✅ Menggunakan `SharedPreferences` untuk data sederhana (key-value)
3. ✅ Menggunakan `sqflite` untuk database lokal dengan CRUD operations
4. ✅ Memahami pattern Database Helper dan singleton
5. ✅ Build aplikasi Flutter menjadi APK release
6. ✅ Memahami konsep app signing dan keystore
7. ✅ Mempresentasikan project akhir dengan baik

---

## ⏱️ TIMELINE SESI (Total: 150 menit)

| Durasi   | Topik  | Aktivitas                                       |
| -------- | ------ | ----------------------------------------------- |
| 10 menit | Part 0 | Review & Warm Up                                |
| 15 menit | Part 1 | Konsep Penyimpanan Lokal di Flutter             |
| 15 menit | Part 2 | SharedPreferences — Key-Value Storage           |
| 25 menit | Part 3 | SQLite (sqflite) — Database Lokal               |
| 25 menit | Part 4 | Task Manager App — Hands-On (MAIN PROJECT)      |
| 15 menit | Part 5 | Build APK, Release & App Signing                |
| 20 menit | Part 6 | Project Akhir: Tips & Best Practices             |
| 25 menit | Part 7 | Presentasi Project Akhir                       |

---

## 📂 RESOURCES

> 💡 **File demo tersedia di folder `contoh_kode/pertemuan_7/`**

| File                              | Deskripsi                                              |
| --------------------------------- | ------------------------------------------------------ |
| `01_shared_prefs_demo.dart`       | SharedPreferences: simpan & baca data sederhana        |
| `02_sqflite_basics_demo.dart`     | SQLite: create, read, update, delete operations        |
| `03_database_helper.dart`         | Singleton pattern untuk Database Helper                |
| `04_task_model.dart`              | Model class untuk Task dengan fromMap/toMap            |
| `05_task_app_complete/`           | Task Manager App lengkap (praktikum solution)          |

---

## 📋 PERSIAPAN SEBELUM MEMULAI

- ✅ Flutter SDK terinstall
- ✅ Editor (VS Code / Android Studio) ready
- ✅ Device / emulator running
- ✅ Review materi Pertemuan 6 (Networking/API)
- ✅ Install dependencies:

```bash
flutter pub add shared_preferences
flutter pub add sqflite
flutter pub add path
flutter pub add path_provider
flutter pub add provider
```

---

## 🔄 PART 0: Review & Warm Up (10 menit)

### Quick Quiz (5 menit)

**Jawab pertanyaan berikut untuk check understanding:**

1. **Apa bedanya GET dan POST di HTTP?**
2. **Bagaimana cara parsing JSON ke Dart object?**
3. **Apa fungsi FutureBuilder?**
4. **Kenapa perlu model class untuk data API?**
5. **Apa yang terjadi jika tidak ada internet saat fetch data?**

> 💡 **JANGAN LANJUT** sebelum yakin paham REST API dari Pertemuan 6!

### Today's Challenge: Data yang Bertahan! (5 menit)

**Scenario:**

> Di Pertemuan 6, kita sudah bisa ambil data dari internet. Tapi...
>
> ❌ Tutup app? Data dari API hilang (kecuali di-cache di memory).
> ❌ Offline? App tidak bisa akses data.
> ❌ Input user? Hilang saat app ditutup.
>
> **Pertanyaan**: Bagaimana Instagram atau WhatsApp bisa menyimpan:
> - Login session (tetap login meski app ditutup)?
> - Chat history (bisa dibaca offline)?
> - Settings (theme, notification preferences)?

**Jawaban**: Mereka menggunakan **penyimpanan lokal** di device! 💾

```
📱 App Flutter                    💾 Penyimpanan Lokal
┌──────────────┐                 ┌──────────────────┐
│              │  "Simpan data"  │                  │
│  Dari API    │ ───────────────>│  SharedPrefs     │
│  atau Input  │                 │  atau SQLite     │
│  User        │ <───────────────│                  │
│              │  "Baca data"    │                  │
└──────────────┘                 └──────────────────┘
```

> 💡 **Bridge dari P6**: Di Pertemuan 6, data dari API hanya tersedia saat online. Sekarang kita belajar **menyimpan** data tersebut secara lokal supaya tetap bisa diakses **offline**!

---

## 💾 PART 1: Konsep Penyimpanan Lokal di Flutter (15 menit)

### Kenapa Perlu Penyimpanan Lokal?

| Problem | Tanpa Storage | Dengan Storage |
| ------- | ------------- | -------------- |
| Offline | ❌ App kosong | ✅ Data tersedia |
| Performance | ❌ Fetch terus | ✅ Load dari local (cepat!) |
| User Data | ❌ Hilang saat tutup app | ✅ Persist antar session |
| Settings | ❌ Reset default | ✅ Tersimpan |

### 💡 ANALOGI: Penyimpanan Lokal = Lemari & Gudang 🏭

> **SharedPreferences** = **Lemari kecil di meja** 🗄️
> - Simpan barang kecil dan sering dipakai
> - Contoh: kunci, pensil, sticky notes (settings, token, flag)
> - Cepat diambil, tidak perlu index
>
> **SQLite** = **Gudang besar dengan sistem** 📦
> - Simpan banyak barang dengan terstruktur
> - Punya katalog, rak, dan label (tables, rows, columns)
> - Bisa cari, urutkan, filter (query)
> - Cocok untuk data kompleks dan besar (chat, to-do, notes)

### Pilihan Penyimpanan di Flutter

```
┌─────────────────────────────────────────────────────────────┐
│                 PENYIMPANAN DI FLUTTER                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📁 File System (path_provider)                             │
│  ├── Application Documents                                  │
│  ├── Temporary Directory                                    │
│  └── External Storage (Android)                             │
│                                                             │
│  🔑 Key-Value (shared_preferences)                          │
│  ├── Settings & preferences                                 │
│  ├── Boolean flags (onboarding_shown)                       │
│  └── Small strings, numbers                                 │
│                                                             │
│  🗄️ Database (sqflite)                                      │
│  ├── Structured data                                        │
│  ├── Relational data                                        │
│  └── Large datasets                                         │
│                                                             │
│  🔐 Secure Storage (flutter_secure_storage)                 │
│  ├── Passwords, tokens, API keys                            │
│  └── Encrypted with Keychain/Keystore                       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Kapan Pakai Apa?

| Use Case | Pilihan | Contoh |
|----------|---------|--------|
| Settings user | SharedPreferences | Dark mode, language, login status |
| Token/Session | flutter_secure_storage | JWT token, API key |
| Simple cache | SharedPreferences | Last sync time, user ID |
| To-do list, notes | SQLite | Task manager, journal app |
| Chat history | SQLite | WhatsApp, Telegram |
| Product catalog | SQLite | E-commerce offline mode |
| Large files | File System | Images, documents, audio |

---

## 🔑 PART 2: SharedPreferences (15 menit)

### Apa itu SharedPreferences?

**SharedPreferences** = penyimpanan key-value sederhana yang **persistent** (tetap ada meski app ditutup).

```
┌─────────────────────────────────────┐
│     SharedPreferences Storage       │
├─────────────────────────────────────┤
│  Key              │  Value          │
├───────────────────┼─────────────────┤
│  "isLoggedIn"     │  true           │
│  "username"       │  "anton"        │
│  "darkMode"       │  false          │
│  "lastSync"       │  1640000000     │
│  "onboardingDone" │  true           │
└───────────────────┴─────────────────┘
```

**Bisa menyimpan:**
- `int` → counter, timestamp
- `double` → rating, progress
- `bool` → flag, toggle
- `String` → nama, token
- `List<String>` → tags, categories

### 🎯 EKSPERIMEN 1: SharedPreferences Basics (7 menit)

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: SharedPrefsDemoPage(),
));

class SharedPrefsDemoPage extends StatefulWidget {
  const SharedPrefsDemoPage({super.key});

  @override
  State<SharedPrefsDemoPage> createState() => _SharedPrefsDemoPageState();
}

class _SharedPrefsDemoPageState extends State<SharedPrefsDemoPage> {
  late SharedPreferences _prefs;
  bool _isLoading = true;
  
  // Data yang akan disimpan
  String _username = '';
  bool _isDarkMode = false;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load data dari SharedPreferences
  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    
    setState(() {
      _username = _prefs.getString('username') ?? 'Guest';
      _isDarkMode = _prefs.getBool('darkMode') ?? false;
      _counter = _prefs.getInt('counter') ?? 0;
      _isLoading = false;
    });
  }

  // Save data ke SharedPreferences
  Future<void> _saveUsername(String value) async {
    await _prefs.setString('username', value);
    setState(() => _username = value);
  }

  Future<void> _toggleDarkMode(bool value) async {
    await _prefs.setBool('darkMode', value);
    setState(() => _isDarkMode = value);
  }

  Future<void> _incrementCounter() async {
    final newValue = _counter + 1;
    await _prefs.setInt('counter', newValue);
    setState(() => _counter = newValue);
  }

  Future<void> _clearAll() async {
    await _prefs.clear(); // Hapus semua data!
    setState(() {
      _username = 'Guest';
      _isDarkMode = false;
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _clearAll,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      controller: TextEditingController(text: _username),
                      decoration: const InputDecoration(
                        hintText: 'Enter username',
                        suffixIcon: Icon(Icons.person),
                      ),
                      onSubmitted: _saveUsername,
                    ),
                    const SizedBox(height: 8),
                    Text('Saved: $_username', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Dark Mode Toggle
            Card(
              child: SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('This persists after app restart'),
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Counter
            Card(
              child: ListTile(
                title: const Text('Counter'),
                subtitle: Text('Value: $_counter'),
                trailing: ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('+1'),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 Try this:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('1. Change username and toggle dark mode'),
                  Text('2. Close the app completely (swipe away)'),
                  Text('3. Reopen the app — settings persist!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Hot Reload!** Coba:
1. Ganti username, toggle dark mode, increment counter
2. **Hot restart** (bukan hot reload) → data tetap ada!
3. Klik "Clear All" → semua data hilang

### API SharedPreferences

```dart
// Get instance (singleton)
final prefs = await SharedPreferences.getInstance();

// WRITE
await prefs.setString('key', 'value');
await prefs.setInt('count', 42);
await prefs.setBool('isActive', true);
await prefs.setDouble('rating', 4.5);
await prefs.setStringList('tags', ['flutter', 'dart']);

// READ (selalu nullable — pakai ?? untuk default)
String? name = prefs.getString('key'); // bisa null
String name = prefs.getString('key') ?? 'Default'; // dengan default

int count = prefs.getInt('count') ?? 0;
bool isActive = prefs.getBool('isActive') ?? false;
List<String>? tags = prefs.getStringList('tags');

// DELETE
await prefs.remove('key'); // hapus satu key
await prefs.clear(); // hapus semua!

// CHECK
bool hasKey = prefs.containsKey('key');
```

### Pattern: SharedPreferences Service

```dart
// lib/services/prefs_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;
  
  // Initialize once
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // Getters
  static bool get isLoggedIn => _prefs?.getBool('isLoggedIn') ?? false;
  static String get username => _prefs?.getString('username') ?? '';
  static bool get darkMode => _prefs?.getBool('darkMode') ?? false;
  
  // Setters
  static Future<bool> setLoggedIn(bool value) async {
    return await _prefs?.setBool('isLoggedIn', value) ?? false;
  }
  
  static Future<bool> setUsername(String value) async {
    return await _prefs?.setString('username', value) ?? false;
  }
  
  static Future<bool> setDarkMode(bool value) async {
    return await _prefs?.setBool('darkMode', value) ?? false;
  }
  
  // Clear
  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }
}

// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init(); // Init di awal
  runApp(const MyApp());
}

// Penggunaan
PrefsService.setUsername('Anton');
print(PrefsService.username); // Anton
```

> ⚠️ **TROUBLESHOOTING — SharedPreferences**:
>
> **Problem**: "Unhandled Exception: MissingPluginException"
>
> - **Cause**: SharedPreferences belum di-init atau hot reload issue
> - **Fix**: Full restart atau `flutter clean` + `flutter pub get`
>
> **Problem**: Data tidak tersimpan
>
> - **Cause**: Lupa `await` saat set value
> - **Fix**: Selalu pakai `await prefs.setXxx()`
>
> **Problem**: Null saat get data
>
> - **Cause**: Key belum pernah diset
> - **Fix**: Pakai `??` untuk default value

---

## 🗄️ PART 3: SQLite (sqflite) (25 menit)

### Apa itu SQLite?

**SQLite** = database relational yang **embedded** (tidak perlu server) dan **zero-configuration**.

```
┌─────────────────────────────────────────────┐
│            SQLite Database                  │
├─────────────────────────────────────────────┤
│                                             │
│  📋 Table: tasks                            │
│  ┌────┬─────────────────┬─────────┬────────┐│
│  │ id │ title           │ status  │ dueDate││
│  ├────┼─────────────────┼─────────┼────────┤│
│  │ 1  │ Belajar Flutter │ pending │ 2026-04││
│  │ 2  │ Membuat App     │ done    │ 2026-03││
│  │ 3  │ Presentasi      │ pending │ 2026-04││
│  └────┴─────────────────┴─────────┴────────┘│
│                                             │
│  📋 Table: users                            │
│  ┌────┬──────────┬─────────────┐            │
│  │ id │ username │ email       │            │
│  ├────┼──────────┼─────────────┤            │
│  │ 1  │ anton    │ a@email.com │            │
│  └────┴──────────┴─────────────┘            │
│                                             │
└─────────────────────────────────────────────┘
```

### SQL Basics

```sql
-- CREATE TABLE
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  isCompleted INTEGER DEFAULT 0,
  createdAt TEXT
);

-- INSERT
INSERT INTO tasks (title, description, isCompleted)
VALUES ('Belajar Flutter', 'Mempelajari SQLite', 0);

-- SELECT
SELECT * FROM tasks;
SELECT * FROM tasks WHERE isCompleted = 0;
SELECT * FROM tasks ORDER BY createdAt DESC;

-- UPDATE
UPDATE tasks 
SET isCompleted = 1 
WHERE id = 1;

-- DELETE
DELETE FROM tasks WHERE id = 1;
```

### 🎯 EKSPERIMEN 2: SQLite Basics (10 menit)

```dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: SQLiteDemoPage(),
));

class Task {
  final int? id;
  final String title;
  final bool isCompleted;

  Task({this.id, required this.title, this.isCompleted = false});

  // Convert Task → Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0, // bool → int
    };
  }

  // Convert Map → Task (from SQLite)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] == 1, // int → bool
    );
  }
}

class SQLiteDemoPage extends StatefulWidget {
  const SQLiteDemoPage({super.key});

  @override
  State<SQLiteDemoPage> createState() => _SQLiteDemoPageState();
}

class _SQLiteDemoPageState extends State<SQLiteDemoPage> {
  Database? _database;
  List<Task> _tasks = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    // 1. Get database path
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    // 2. Open/create database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create table saat pertama kali
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            isCompleted INTEGER DEFAULT 0
          )
        ''');
      },
    );

    // 3. Load existing tasks
    await _loadTasks();
  }

  Future<void> _loadTasks() async {
    if (_database == null) return;

    // SELECT * FROM tasks
    final List<Map<String, dynamic>> maps = await _database!.query('tasks');

    setState(() {
      _tasks = maps.map((map) => Task.fromMap(map)).toList();
    });
  }

  Future<void> _addTask(String title) async {
    if (_database == null || title.isEmpty) return;

    final task = Task(title: title);

    // INSERT INTO tasks
    await _database!.insert('tasks', task.toMap());

    _controller.clear();
    await _loadTasks(); // Refresh list
  }

  Future<void> _toggleTask(Task task) async {
    if (_database == null) return;

    final updated = Task(
      id: task.id,
      title: task.title,
      isCompleted: !task.isCompleted,
    );

    // UPDATE tasks SET ... WHERE id = ?
    await _database!.update(
      'tasks',
      updated.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );

    await _loadTasks();
  }

  Future<void> _deleteTask(int id) async {
    if (_database == null) return;

    // DELETE FROM tasks WHERE id = ?
    await _database!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    await _loadTasks();
  }

  Future<void> _clearAll() async {
    if (_database == null) return;

    await _database!.delete('tasks'); // DELETE ALL
    await _loadTasks();
  }

  @override
  void dispose() {
    _database?.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _clearAll,
            tooltip: 'Delete All',
          ),
        ],
      ),
      body: Column(
        children: [
          // Input
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter new task...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _addTask,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTask(_controller.text),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet.\nAdd one above!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (_) => _toggleTask(task),
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted ? Colors.grey : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(task.id!),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
```

### Database Helper Pattern (Best Practice)

```dart
// lib/services/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Database config
  static const String _dbName = 'task_manager.db';
  static const int _dbVersion = 1;
  static const String tableTasks = 'tasks';

  // Column names
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

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
    );
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

  // CRUD Operations

  // CREATE
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(tableTasks, task.toMap());
  }

  // READ ALL
  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableTasks);
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  // READ BY ID
  Future<Task?> getTask(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableTasks,
      where: '$colId = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    }
    return null;
  }

  // UPDATE
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      tableTasks,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
  }

  // DELETE
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      tableTasks,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  // DELETE ALL
  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete(tableTasks);
  }

  // GET COUNT
  Future<int> getTaskCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $tableTasks');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
```

> ⚠️ **TROUBLESHOOTING — SQLite**:
>
> **Problem**: "DatabaseException: no such table"
>
> - **Cause**: Schema berubah tapi version tidak di-update
> - **Fix**: Uninstall app atau increment `version` di `openDatabase`
>
> **Problem**: "type 'int' is not a subtype of type 'bool'"
>
> - **Cause**: SQLite tidak punya boolean, pakai INTEGER (0/1)
> - **Fix**: Konversi saat toMap/fromMap
>
> **Problem**: Database locked
>
> - **Cause**: Multiple connections atau transaction belum selesai
> - **Fix**: Gunakan singleton pattern, pastikan close() dipanggil

---

## 🚀 PART 4: Task Manager App — Hands-On (25 menit)

### Apa yang Akan Kita Bangun?

Aplikasi **Task Manager** lengkap dengan:

- ✅ CRUD tasks dengan SQLite
- ✅ Mark task as complete/incomplete
- ✅ Settings dengan SharedPreferences
- ✅ Provider untuk state management
- ✅ Search dan filter tasks
- ✅ Persist data setelah app restart

```
┌──────────────────────────────┐
│      Task Manager App        │
├──────────────────────────────┤
│                              │
│  🔍 [Search tasks...]        │
│                              │
│  ☐ Belajar Flutter     🗑️  │
│  ☑ Review materi P6    🗑️  │
│  ☐ Presentasi project  🗑️  │
│                              │
│  ┌────┐                      │
│  │ +  │  Add new task        │
│  └────┘                      │
│                              │
│  [⚙️ Settings]                │
│  - Dark Mode: ON/OFF         │
│  - Sort by: Date/Name        │
│                              │
└──────────────────────────────┘
```

### Step 1: Setup Project (3 menit)

```bash
flutter create task_manager
cd task_manager
flutter pub add sqflite shared_preferences provider path
```

**Struktur folder:**

```
lib/
├── main.dart
├── models/
│   └── task.dart
├── services/
│   ├── database_helper.dart
│   └── prefs_service.dart
├── providers/
│   └── task_provider.dart
└── pages/
    ├── task_list_page.dart
    └── settings_page.dart
```

### Step 2: Task Model (3 menit)

**Create**: `lib/models/task.dart`

```dart
class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      isCompleted: map['isCompleted'] == 1,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
```

### Step 3: Database Helper (5 menit)

**Create**: `lib/services/database_helper.dart`

(Gunakan pattern dari Part 3, tambahkan search/filter)

```dart
// Add these methods to DatabaseHelper:

// Search tasks
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

// Get filtered tasks
Future<List<Task>> getTasks({bool? isCompleted}) async {
  final db = await database;
  
  if (isCompleted != null) {
    final maps = await db.query(
      tableTasks,
      where: '$colIsCompleted = ?',
      whereArgs: [isCompleted ? 1 : 0],
    );
    return maps.map((m) => Task.fromMap(m)).toList();
  }
  
  return getAllTasks();
}
```

### Step 4: SharedPreferences Service (2 menit)

**Create**: `lib/services/prefs_service.dart`

(Gunakan pattern dari Part 2)

```dart
class PrefsService {
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  static bool get darkMode => _prefs?.getBool('darkMode') ?? false;
  static Future<bool> setDarkMode(bool v) async =>
      await _prefs?.setBool('darkMode', v) ?? false;
}
```

### Step 5: Task Provider (5 menit)

**Create**: `lib/providers/task_provider.dart`

```dart
import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/database_helper.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Task> get tasks => _searchQuery.isEmpty ? _tasks : _filteredTasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _db.getAllTasks();
      _applyFilter();
      _error = null;
    } catch (e) {
      _error = 'Failed to load tasks: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String title, {String description = ''}) async {
    try {
      final task = Task(title: title, description: description);
      await _db.insertTask(task);
      await loadTasks();
    } catch (e) {
      _error = 'Failed to add task: $e';
      notifyListeners();
    }
  }

  Future<void> toggleTask(Task task) async {
    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await _db.updateTask(updated);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _db.deleteTask(id);
    await loadTasks();
  }

  void search(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredTasks = [];
    } else {
      _filteredTasks = _tasks.where((t) =>
        t.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  void _applyFilter() {
    if (_searchQuery.isNotEmpty) {
      search(_searchQuery);
    }
  }
}
```

### Step 6: Main & App (2 menit)

**Edit**: `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/task_provider.dart';
import 'services/prefs_service.dart';
import 'pages/task_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: PrefsService.darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const TaskListPage(),
      ),
    );
  }
}
```

### Step 7: Task List Page (5 menit)

**Create**: `lib/pages/task_list_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'settings_page.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: context.read<TaskProvider>().search,
            ),
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          final tasks = provider.tasks;

          if (tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No tasks yet', style: TextStyle(fontSize: 18)),
                  Text('Tap + to add a task', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => provider.toggleTask(task),
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: task.isCompleted ? Colors.grey : null,
                  ),
                ),
                subtitle: Text(
                  task.createdAt.toString().split(' ')[0],
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => provider.deleteTask(task.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Task title'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<TaskProvider>().addTask(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
```

**Test sekarang!** 🎉

---

## 📦 PART 5: Build APK & Release (15 menit)

### Build Commands

```bash
# Development build (debug)
flutter run

# Profile build (testing performance)
flutter build apk --profile

# Release build (production)
flutter build apk --release

# Release untuk specific ABI
flutter build apk --release --split-per-abi

# App Bundle (for Play Store)
flutter build appbundle --release
```

### Output Location

```
build/
└── app/
    └── outputs/
        └── flutter-apk/
            ├── app-debug.apk
            ├── app-release.apk          # ← Use this
            └── app-armeabi-v7a-release.apk  # Split ABI
```

### APK Sizes (Typical)

| Type | Size |
|------|------|
| Debug | ~50-80 MB |
| Release | ~15-25 MB |
| Split ABI | ~10-15 MB per ABI |

### Signing Configuration

**Android** memerlukan **keystore** untuk sign APK release.

**Create keystore** (one-time):

```bash
# Create keystore
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload

# For Windows:
keytool -genkey -v -keystore %USERPROFILE%\upload-keystore.jks -keyalg RSA ^
  -keysize 2048 -validity 10000 -alias upload
```

**Configure**: `android/app/build.gradle`

```gradle
android {
    // ...
    
    signingConfigs {
        release {
            keyAlias 'upload'
            keyPassword 'your-key-password'
            storeFile file('upload-keystore.jks')
            storePassword 'your-store-password'
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

> ⚠️ **PENTING**: Jangan commit keystore ke GitHub! Add ke `.gitignore`:
> ```
> *.jks
> key.properties
> ```

### Install APK

```bash
# Install ke device
flutter install

# Or manually with adb
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎓 PART 6: Project Akhir — Tips & Best Practices (20 menit)

### Checklist Project Akhir

| Requirement | Status | Notes |
|-------------|--------|-------|
| 4+ screens | ☐ | Navigasi berfungsi |
| State management (Provider) | ☐ | Bukan setState global |
| Form dengan validasi | ☐ | Minimal 1 form |
| API atau Local Storage | ☐ | Pilih salah satu atau kombinasi |
| UI responsif & menarik | ☐ | Konsisten, modern |
| APK dapat diinstall | ☐ | Test di device |
| README dokumentasi | ☐ | Deskripsi, screenshot, cara run |

### Struktur Folder yang Rapi

```
lib/
├── main.dart
├── app.dart                    # App configuration
├── constants/
│   ├── colors.dart
│   ├── strings.dart
│   └── api_constants.dart
├── models/                     # Data classes
│   ├── user.dart
│   └── product.dart
├── services/                   # API & Database
│   ├── api_service.dart
│   └── database_helper.dart
├── providers/                  # State management
│   ├── auth_provider.dart
│   └── product_provider.dart
├── pages/                      # Screens
│   ├── home/
│   │   ├── home_page.dart
│   │   └── widgets/
│   ├── auth/
│   │   ├── login_page.dart
│   │   └── register_page.dart
│   └── profile/
│       └── profile_page.dart
├── widgets/                    # Reusable widgets
│   ├── custom_button.dart
│   ├── loading_indicator.dart
│   └── error_widget.dart
└── utils/                      # Helpers
    ├── date_formatter.dart
    └── validators.dart
```

### Tips Presentasi (5 menit demo)

**Struktur presentasi:**

1. **Intro** (30 detik)
   - Nama app & tujuan
   - Target user

2. **Demo Fitur** (3 menit)
   - Login/register jika ada
   - Fitur utama
   - Navigasi antar screen
   - State management (show data update)

3. **Tech Stack** (30 detik)
   - Flutter version
   - State management
   - API/Storage yang dipakai

4. **Challenges** (30 detik)
   - Apa yang sulit?
   - Bagaimana solve?

5. **Q&A** (30 detik)
   - Siap jawab pertanyaan

### Penilaian Project Akhir

| Kriteria | 25% | 20% | 20% | 25% | 10% |
|----------|-----|-----|-----|-----|-----|
| **Kompleksitas** | 4 screens | Navigasi | State mgmt | Form | API/Storage |
| **Kode** | Clean | Terstruktur | Dokumentasi | Reusable | Best practices |
| **UI/UX** | Modern | Konsisten | Responsif | Accessibility | Animasi |
| **Fungsional** | No crash | Semua fitur work | Edge cases | Error handling | Loading states |
| **Presentasi** | Jelas | Demo lancar | Explain code | Q&A handled | Waktu |

---

## 🎉 PART 7: Presentasi Project Akhir (25 menit)

### Format Presentasi

| Mahasiswa | Durasi | Aktivitas |
|-----------|--------|-----------|
| Per kelompok/individu | 5 menit | Presentasi + demo |
|  | 2 menit | Q&A dari dosen/peers |
|  | 1 menit | Feedback & scoring |

### Yang Dinilai Saat Presentasi

✅ **Kejelasan penjelasan** — bisa menjelaskan arsitektur app  
✅ **Kelancaran demo** — tidak crash, flow logic  
✅ **Pemahaman kode** — bisa jelaskan bagian penting  
✅ **Tanggapan Q&A** — bisa jawab pertanyaan  

### Deliverables yang Harus Dikumpulkan

1. 📁 **Source code** di GitHub repository
2. 📱 **File APK** release
3. 📄 **README.md** dengan:
   - Nama aplikasi & deskripsi
   - Screenshot (minimal 3)
   - Fitur-fitur
   - Cara install & run
   - Tech stack
4. 🎥 **Video demo** (opsional, 2-3 menit)

---

## 📚 LATIHAN & TUGAS

### Latihan In-Class

1. **Tambahkan fitur ke Task Manager:**
   - Edit task (update title/description)
   - Filter by status (all/completed/pending)
   - Sort by date (newest/oldest)

2. **Build APK release** dari project Task Manager

### Tugas Praktikum (Deadline: H+7)

**Buat aplikasi pilihan Anda** dengan requirement:

**Minimal features:**
- ✅ 4+ halaman dengan navigasi
- ✅ Minimal 1 form dengan validasi
- ✅ SQLite untuk penyimpanan lokal
- ✅ SharedPreferences untuk settings
- ✅ Provider untuk state management

**Ide aplikasi:**
1. **Notes App** — buat, edit, hapus notes dengan kategori
2. **Habit Tracker** — track kebiasaan harian dengan streak
3. **Expense Tracker** — catat pengeluaran dengan kategori
4. **Recipe Book** — koleksi resep dengan gambar & favorit
5. **Contact Manager** — daftar kontak dengan search & filter

**Deliverables:**
- Link GitHub repository
- File APK (attach di release)
- Screenshot di README

---

## 🔗 REFERENSI

### Dokumentasi

- [SharedPreferences Package](https://pub.dev/packages/shared_preferences)
- [sqflite Package](https://pub.dev/packages/sqflite)
- [Flutter Build & Release](https://docs.flutter.dev/deployment/android)
- [SQLite Tutorial](https://www.sqlitetutorial.net/)

### Tools

- [DB Browser for SQLite](https://sqlitebrowser.org/) — GUI untuk lihat database
- [APK Analyzer](https://developer.android.com/studio/debug/apk-analyzer) — Analisis size APK

---

## ✅ SUMMARY

**Hari ini kita pelajari:**

| Topik | Key Takeaway |
|-------|-------------|
| SharedPreferences | Key-value storage untuk data sederhana (settings, flags) |
| SQLite | Database lokal untuk data terstruktur (CRUD operations) |
| Database Helper | Singleton pattern untuk manage database connection |
| Build APK | `flutter build apk --release` + app signing |
| Project Akhir | Kombinasi semua materi + presentasi |

**Selamat! 🎉 Anda sudah menyelesaikan semua 7 pertemuan Flutter!**

---

> _"The only way to learn a new programming language is by writing programs in it."_ — Dennis Ritchie
