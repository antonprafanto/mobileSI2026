// 06_selector_optimization_demo.dart
// Demo: Selector untuk Performance Optimization
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
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MaterialApp(
        title: 'Selector Optimization Demo',
        theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}

// Model with multiple properties
class CounterModel extends ChangeNotifier {
  int _counterA = 0;
  int _counterB = 0;

  int get counterA => _counterA;
  int get counterB => _counterB;

  void incrementA() {
    _counterA++;
    notifyListeners(); // Notifies ALL listeners
  }

  void incrementB() {
    _counterB++;
    notifyListeners(); // Notifies ALL listeners
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selector Optimization'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⚠️ BAD: Consumer rebuilds on ANY change',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Widget rebuilds even when counterA doesn\'t change!',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const BadCounterAWidget(), // Using Consumer
            const SizedBox(height: 32),
            const Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✅ GOOD: Selector rebuilds only when counterA changes',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Widget rebuilds ONLY when counterA changes!',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const GoodCounterAWidget(), // Using Selector
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CounterModel>().incrementA();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text('Increment A'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CounterModel>().incrementB();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text('Increment B'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💡 Test Instructions:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Click "Increment B" button',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      '2. Watch console logs',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      '3. BAD widget rebuilds (❌)',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      '4. GOOD widget does NOT rebuild (✅)',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BAD: Consumer rebuilds on ANY model change
class BadCounterAWidget extends StatelessWidget {
  const BadCounterAWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, model, child) {
        print('❌ BAD: BadCounterAWidget rebuilt! (Consumer)');
        return Card(
          color: Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Counter A (Consumer)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  '${model.counterA}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const Text(
                  'Rebuilds on ANY change ❌',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// GOOD: Selector rebuilds only when counterA changes
class GoodCounterAWidget extends StatelessWidget {
  const GoodCounterAWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CounterModel, int>(
      selector: (context, model) => model.counterA, // Select only counterA
      builder: (context, counterA, child) {
        print('✅ GOOD: GoodCounterAWidget rebuilt! (Selector)');
        return Card(
          color: Colors.green.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Counter A (Selector)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  '$counterA',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const Text(
                  'Rebuilds ONLY when counterA changes ✅',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
