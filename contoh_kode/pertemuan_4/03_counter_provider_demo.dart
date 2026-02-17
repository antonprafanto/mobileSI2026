// 03_counter_provider_demo.dart
// Demo: Counter Solution dengan Provider (Clean!)
// Pertemuan 4 - State Management dengan Provider
// REQUIRES: flutter pub add provider

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap app with ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MaterialApp(
        title: 'Counter Provider Demo',
        theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
        home: const CounterPage(),
      ),
    );
  }
}

// ChangeNotifier Model
class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notify all listeners to rebuild!
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter with Provider'),
        backgroundColor: Colors.green,
        actions: [
          // Badge using Consumer
          Consumer<CounterModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${model.counter}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter value:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Consumer listens to CounterModel changes
            Consumer<CounterModel>(
              builder: (context, model, child) {
                print('🟢 Counter widget rebuilt with value: ${model.counter}');
                return Text(
                  '${model.counter}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Use context.read to call method (no rebuild)
                    context.read<CounterModel>().increment();
                  },
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => context.read<CounterModel>().reset(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '💡 Check console to see rebuild logs!',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DisplayPage()),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View on Another Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Counter from Provider:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Access same CounterModel - no props passed!
            Consumer<CounterModel>(
              builder: (context, model, child) {
                return Text(
                  '${model.counter}',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '✅ No props passed!',
              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const Text(
              '✅ Direct access via Provider!',
              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            const Text(
              'You can increment from home page,',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Text(
              'and this page will auto-update!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
