# -*- coding: utf-8 -*-
"""Create ALL Pertemuan 4 demo files efficiently"""

# Demo 01: Counter dengan setState
demo_01 = """// 01_counter_setstate_demo.dart
// Demo: Counter dengan setState (Baseline)
// Pertemuan 4 - State Management dengan Provider

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter setState Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0; // Ephemeral state - local to this widget

  void _increment() {
    setState(() {
      _counter++; // Modify state + trigger rebuild
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('🔴 CounterPage rebuilt!'); // See rebuilds in console
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter with setState'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increment,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
"""

with open('contoh_kode/pertemuan_4/01_counter_setstate_demo.dart', 'w', encoding='utf-8') as f:
    f.write(demo_01)
print("✅ Created 01_counter_setstate_demo.dart")

# Demo 02: Prop Drilling Problem
demo_02 = """// 02_prop_drilling_problem_demo.dart
// Demo: Problem - Passing state 3 levels deep (Prop Drilling Hell)
// Pertemuan 4 - State Management dengan Provider

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prop Drilling Problem',
      theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

// LEVEL 1: HomePage has the state
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _increment() {
    setState(() => _counter++);
  }

  void _reset() {
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Level 1)'),
        actions: [
          // Badge showing counter
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $_counter', style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increment,
              child: const Text('Increment'),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      counter: _counter,      // ← Pass counter
                      onReset: _reset,        // ← Pass callback
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Go to Profile (Level 2)'),
            ),
          ],
        ),
      ),
    );
  }
}

// LEVEL 2: ProfilePage doesn't use onReset, just passes it!
class ProfilePage extends StatelessWidget {
  final int counter;           // ← Receive from HomePage
  final VoidCallback onReset;  // ← Receive callback

  const ProfilePage({
    super.key,
    required this.counter,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile (Level 2)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Points: $counter', // ← Use counter here
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              '⚠️ ProfilePage just PASSES onReset',
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
            const Text(
              'Doesn\\'t use it! Just a courier!',
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      counter: counter,    // ← Pass AGAIN!
                      onReset: onReset,    // ← Pass AGAIN!
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Go to Settings (Level 3)'),
            ),
          ],
        ),
      ),
    );
  }
}

// LEVEL 3: SettingsPage FINALLY uses onReset!
class SettingsPage extends StatelessWidget {
  final int counter;           // ← Receive from Profile (from Home!)
  final VoidCallback onReset;  // ← Receive from Profile (from Home!)

  const SettingsPage({
    super.key,
    required this.counter,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings (Level 3)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 80),
            const SizedBox(height: 20),
            Text(
              'Current Points: $counter',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            const Text(
              '💡 This is 2 levels deep from HomePage!',
              style: TextStyle(fontSize: 12, color: Colors.orange),
            ),
            const SizedBox(height: 10),
            const Text(
              'HomePage → ProfilePage → SettingsPage',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                onReset(); // ← FINALLY use callback 2 levels deep!
                Navigator.pop(context);
                Navigator.pop(context); // Back to home
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Points'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
"""

with open('contoh_kode/pertemuan_4/02_prop_drilling_problem_demo.dart', 'w', encoding='utf-8') as f:
    f.write(demo_02)
print("✅ Created 02_prop_drilling_problem_demo.dart")

print("\\n✅ Pertemuan 4 demos 01-02 created!")
print("Continue creating 03-06...")
