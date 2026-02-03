// =============================================================================
// 📱 PERTEMUAN 2 - DEMO 5: THEMING
// =============================================================================
// Demonstrates: ThemeData, ColorScheme, Dark/Light Mode
// CARA MENJALANKAN: Copy ke main.dart dan jalankan flutter run
// =============================================================================

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode mode) {
    setState(() => _themeMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Demo',
      debugShowCheckedModeBanner: false,
      // Light Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.light),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        cardTheme: CardTheme(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      // Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        cardTheme: CardTheme(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      themeMode: _themeMode,
      home: ThemeDemoPage(onThemeChange: _toggleTheme, currentMode: _themeMode),
    );
  }
}

class ThemeDemoPage extends StatelessWidget {
  final Function(ThemeMode) onThemeChange;
  final ThemeMode currentMode;

  const ThemeDemoPage({super.key, required this.onThemeChange, required this.currentMode});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Mode Buttons
            const Text('1. Theme Mode', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _themeButton('Light', ThemeMode.light, Icons.light_mode),
                const SizedBox(width: 8),
                _themeButton('Dark', ThemeMode.dark, Icons.dark_mode),
                const SizedBox(width: 8),
                _themeButton('System', ThemeMode.system, Icons.settings),
              ],
            ),
            Text('Current: ${currentMode.name}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const Divider(height: 32),

            // Color Scheme Demo
            const Text('2. ColorScheme Colors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: [
                _colorBox('primary', colorScheme.primary),
                _colorBox('secondary', colorScheme.secondary),
                _colorBox('tertiary', colorScheme.tertiary),
                _colorBox('error', colorScheme.error),
                _colorBox('surface', colorScheme.surface),
                _colorBox('background', colorScheme.surface),
              ],
            ),
            const Divider(height: 32),

            // Text Theme Demo
            const Text('3. Text Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('displayLarge', style: textTheme.displayLarge),
            Text('headlineMedium', style: textTheme.headlineMedium),
            Text('titleLarge', style: textTheme.titleLarge),
            Text('bodyLarge', style: textTheme.bodyLarge),
            Text('labelSmall', style: textTheme.labelSmall),
            const Divider(height: 32),

            // Themed Widgets
            const Text('4. Themed Widgets', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: Icon(Icons.star, color: colorScheme.primary),
                title: const Text('Themed Card'),
                subtitle: const Text('Menggunakan warna dari theme'),
                trailing: Icon(Icons.arrow_forward, color: colorScheme.secondary),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                const SizedBox(width: 8),
                TextButton(onPressed: () {}, child: const Text('Text')),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onThemeChange(currentMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light),
        child: Icon(currentMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
      ),
    );
  }

  Widget _themeButton(String label, ThemeMode mode, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () => onThemeChange(mode),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: currentMode == mode ? Colors.teal : null,
        foregroundColor: currentMode == mode ? Colors.white : null,
      ),
    );
  }

  Widget _colorBox(String name, Color color) {
    return Column(
      children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))),
        Text(name, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}

// =============================================================================
// 📝 CATATAN PENTING (UNTUK PEMULA):
// 
// 1. ThemeData = Pengaturan tampilan seluruh aplikasi
//    - colorScheme: warna-warna yang digunakan
//    - fontFamily: jenis huruf
//    - appBarTheme: styling AppBar
//
// 2. ColorScheme.fromSeed() = Generate warna otomatis dari 1 warna dasar
//    - Lebih mudah daripada menentukan setiap warna manual
//    - seedColor menentukan warna utama
//
// 3. ThemeMode = Mode tema aplikasi
//    - ThemeMode.light = Tema terang
//    - ThemeMode.dark = Tema gelap
//    - ThemeMode.system = Mengikuti pengaturan HP
//
// 4. Mengakses Theme:
//    - Theme.of(context).colorScheme.primary = warna utama
//    - Theme.of(context).textTheme.headlineMedium = style teks
//
// 💡 Tips: Selalu gunakan warna dari Theme, jangan hardcode warna!
//    Ini membuat aplikasi lebih mudah di-maintain dan konsisten.
// =============================================================================

