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
      _filteredTasks = _tasks
          .where((t) => t.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void _applyFilter() {
    if (_searchQuery.isNotEmpty) {
      search(_searchQuery);
    }
  }
}
