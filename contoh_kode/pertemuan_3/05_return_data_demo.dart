// 05_return_data_demo.dart
// Demo: Menerima Return Value dari Page yang ditutup
// Pertemuan 3 - ListView, GridView, dan Navigasi

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Return Data Demo',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedColor = 'No color selected yet';
  Color _bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.palette, size: 80, color: Colors.indigo),
            const SizedBox(height: 24),
            const Text(
              'Selected Color:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedColor,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () async {
                // await untuk terima return value saat page ditutup
                final result = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectColorPage(),
                  ),
                );

                // Update UI dengan data yang dikembalikan
                if (result != null) {
                  setState(() {
                    _selectedColor = result['name'];
                    _bgColor = result['color'];
                  });
                }
              },
              icon: const Icon(Icons.color_lens),
              label: const Text('Select Color'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectColorPage extends StatelessWidget {
  const SelectColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      {'name': 'Red', 'color': Colors.red.shade100},
      {'name': 'Blue', 'color': Colors.blue.shade100},
      {'name': 'Green', 'color': Colors.green.shade100},
      {'name': 'Yellow', 'color': Colors.yellow.shade100},
      {'name': 'Purple', 'color': Colors.purple.shade100},
      {'name': 'Orange', 'color': Colors.orange.shade100},
      {'name': 'Pink', 'color': Colors.pink.shade100},
      {'name': 'Teal', 'color': Colors.teal.shade100},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Color'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final item = colors[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item['color'] as Color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
              ),
              title: Text(
                item['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.check_circle_outline),
              onTap: () {
                // Return data ke page sebelumnya via Navigator.pop
                Navigator.pop(context, item);
              },
            ),
          );
        },
      ),
    );
  }
}
