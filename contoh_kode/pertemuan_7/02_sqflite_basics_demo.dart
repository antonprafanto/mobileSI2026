import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Demo 02: SQLite Basics
/// CRUD operations dengan database lokal

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: SQLiteDemoPage()),
);

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

class SQLiteDemoPage extends StatefulWidget {
  const SQLiteDemoPage({super.key});

  @override
  State<SQLiteDemoPage> createState() => _SQLiteDemoPageState();
}

class _SQLiteDemoPageState extends State<SQLiteDemoPage> {
  Database? _database;
  List<Task> _tasks = [];
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    setState(() => _isLoading = true);

    // 1. Get database path
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'demo_tasks.db');

    // 2. Open/create database
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            isCompleted INTEGER DEFAULT 0,
            createdAt TEXT
          )
        ''');
      },
    );

    await _loadTasks();
    setState(() => _isLoading = false);
  }

  // CRUD Operations

  // CREATE
  Future<void> _addTask() async {
    if (_database == null) return;
    if (_titleController.text.isEmpty) return;

    final task = Task(
      title: _titleController.text,
      description: _descController.text,
    );

    await _database!.insert('tasks', task.toMap());
    _titleController.clear();
    _descController.clear();
    await _loadTasks();

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task added!')));
    }
  }

  // READ
  Future<void> _loadTasks() async {
    if (_database == null) return;

    final maps = await _database!.query('tasks', orderBy: 'createdAt DESC');
    setState(() {
      _tasks = maps.map((m) => Task.fromMap(m)).toList();
    });
  }

  // UPDATE
  Future<void> _updateTask(Task task) async {
    if (_database == null) return;

    final updated = task.copyWith(
      title: _titleController.text,
      description: _descController.text,
    );

    await _database!.update(
      'tasks',
      updated.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );

    _titleController.clear();
    _descController.clear();
    await _loadTasks();
    Navigator.pop(context);
  }

  // DELETE
  Future<void> _deleteTask(int id) async {
    if (_database == null) return;

    await _database!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    await _loadTasks();

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task deleted!')));
    }
  }

  // Toggle completion
  Future<void> _toggleComplete(Task task) async {
    if (_database == null) return;

    final updated = task.copyWith(isCompleted: !task.isCompleted);
    await _database!.update(
      'tasks',
      updated.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    await _loadTasks();
  }

  // Clear all
  Future<void> _clearAll() async {
    if (_database == null) return;

    await _database!.delete('tasks');
    await _loadTasks();

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All tasks cleared!')));
    }
  }

  void _showEditDialog(Task task) {
    _titleController.text = task.title;
    _descController.text = task.description;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _updateTask(task),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _database?.close();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗄️ SQLite Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _clearAll,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Column(
        children: [
          // Input Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Task title',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    hintText: 'Description (optional)',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _addTask,
                    icon: const Icon(Icons.add),
                    label: const Text('ADD TASK'),
                  ),
                ),
              ],
            ),
          ),

          // Stats
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(label: Text('Total: ${_tasks.length}')),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    'Completed: ${_tasks.where((t) => t.isCompleted).length}',
                  ),
                  backgroundColor: Colors.green.shade100,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    'Pending: ${_tasks.where((t) => !t.isCompleted).length}',
                  ),
                  backgroundColor: Colors.orange.shade100,
                ),
              ],
            ),
          ),

          // Task List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _tasks.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No tasks yet', style: TextStyle(fontSize: 18)),
                        Text(
                          'Add your first task above!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (_) => _toggleComplete(task),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.isCompleted ? Colors.grey : null,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (task.description.isNotEmpty)
                                Text(task.description),
                              Text(
                                'Created: ${task.createdAt.toString().split('.')[0]}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _showEditDialog(task),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteTask(task.id!),
                              ),
                            ],
                          ),
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
