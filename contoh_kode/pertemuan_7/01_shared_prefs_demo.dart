import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Demo 01: SharedPreferences Basics
/// Menunjukkan cara simpan dan baca data sederhana

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SharedPrefsDemoPage(),
  ),
);

class SharedPrefsDemoPage extends StatefulWidget {
  const SharedPrefsDemoPage({super.key});

  @override
  State<SharedPrefsDemoPage> createState() => _SharedPrefsDemoPageState();
}

class _SharedPrefsDemoPageState extends State<SharedPrefsDemoPage> {
  late SharedPreferences _prefs;
  bool _isLoading = true;

  // Data
  String _username = '';
  bool _isDarkMode = false;
  int _counter = 0;
  double _rating = 3.0;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = _prefs.getString('username') ?? 'Guest';
      _isDarkMode = _prefs.getBool('darkMode') ?? false;
      _counter = _prefs.getInt('counter') ?? 0;
      _rating = _prefs.getDouble('rating') ?? 3.0;
      _isLoading = false;
    });
  }

  // Save methods
  Future<void> _saveUsername(String value) async {
    await _prefs.setString('username', value);
    setState(() => _username = value);
    _showSnackBar('Username saved: $value');
  }

  Future<void> _toggleDarkMode(bool value) async {
    await _prefs.setBool('darkMode', value);
    setState(() => _isDarkMode = value);
    _showSnackBar('Dark mode: ${value ? 'ON' : 'OFF'}');
  }

  Future<void> _incrementCounter() async {
    final newValue = _counter + 1;
    await _prefs.setInt('counter', newValue);
    setState(() => _counter = newValue);
  }

  Future<void> _setRating(double value) async {
    await _prefs.setDouble('rating', value);
    setState(() => _rating = value);
  }

  Future<void> _clearAll() async {
    await _prefs.clear();
    setState(() {
      _username = 'Guest';
      _isDarkMode = false;
      _counter = 0;
      _rating = 3.0;
    });
    _showSnackBar('All data cleared!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔑 SharedPreferences Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _clearAll,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Info Card
          _buildInfoCard(),
          const SizedBox(height: 16),

          // Username
          _buildCard(
            title: '👤 Username (String)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: TextEditingController(text: _username),
                  decoration: const InputDecoration(
                    hintText: 'Enter username',
                    prefixIcon: Icon(Icons.person),
                  ),
                  onSubmitted: _saveUsername,
                ),
                const SizedBox(height: 8),
                Text(
                  'Saved: $_username',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // Dark Mode
          _buildCard(
            title: '🌙 Dark Mode (bool)',
            child: SwitchListTile(
              title: const Text('Enable Dark Mode'),
              subtitle: const Text('Persists after restart'),
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
            ),
          ),

          // Counter
          _buildCard(
            title: '🔢 Counter (int)',
            child: ListTile(
              title: Text('Value: $_counter'),
              trailing: ElevatedButton.icon(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add),
                label: const Text('+1'),
              ),
            ),
          ),

          // Rating
          _buildCard(
            title: '⭐ Rating (double)',
            child: Column(
              children: [
                Slider(
                  value: _rating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _rating.toString(),
                  onChanged: _setRating,
                ),
                Text('Rating: ${_rating.toStringAsFixed(1)} / 5.0'),
              ],
            ),
          ),

          // Show all keys
          _buildCard(
            title: '📋 All Stored Keys',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _prefs.getKeys().map((key) {
                  final value = _prefs.get(key);
                  return Text('$key: $value (${value.runtimeType})');
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡 Tips:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('1. Edit data di atas'),
          Text('2. Hot restart app (bukan hot reload)'),
          Text('3. Data tetap ada! (persistent)'),
          Text('4. Tap 🗑️ untuk clear semua data'),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
