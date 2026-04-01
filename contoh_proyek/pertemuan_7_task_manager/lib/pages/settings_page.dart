import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/prefs_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _darkMode = PrefsService.darkMode;
  }

  Future<void> _toggleDarkMode(bool value) async {
    await PrefsService.setDarkMode(value);
    setState(() => _darkMode = value);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value ? 'Dark mode enabled' : 'Light mode enabled'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚙️ Settings')),
      body: ListView(
        children: [
          // Dark Mode Toggle
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme across the app'),
            value: _darkMode,
            onChanged: _toggleDarkMode,
            secondary: Icon(_darkMode ? Icons.dark_mode : Icons.light_mode),
          ),

          const Divider(),

          // App Info
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info_outline),
          ),

          // About
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Task Manager App - Pertemuan 7'),
            leading: const Icon(Icons.help_outline),
          ),

          const SizedBox(height: 20),

          // Info Card
          Container(
            margin: const EdgeInsets.all(16),
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
                Text('Settings are saved using SharedPreferences'),
                Text('and will persist after app restart.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
