import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorDemoPage extends StatelessWidget {
  const SelectorDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DualCounter(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Selector Optimization')),
        body: Column(
          children: [
            Expanded(child: Consumer<DualCounter>(
              builder: (context, counter, child) {
                debugPrint('❌ Consumer: Rebuilt on ANY change');
                return Card(
                  color: Colors.red.shade50,
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Consumer (BAD)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Rebuilds on ANY change', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 20),
                      Text('Counter A: ${counter.counterA}', style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                );
              },
            )),
            Expanded(child: Selector<DualCounter, int>(
              selector: (context, counter) => counter.counterA,
              builder: (context, counterA, child) {
                debugPrint('✅ Selector: Rebuilt only when counterA changes');
                return Card(
                  color: Colors.green.shade50,
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Selector (GOOD)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Rebuilds ONLY when counterA changes', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 20),
                      Text('Counter A: $counterA', style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(child: ElevatedButton(
                    onPressed: () => context.read<DualCounter>().incrementA(),
                    child: const Text('Increment A'),
                  )),
                  const SizedBox(width: 16),
                  Expanded(child: ElevatedButton(
                    onPressed: () => context.read<DualCounter>().incrementB(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text('Increment B'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DualCounter extends ChangeNotifier {
  int _counterA = 0;
  int _counterB = 0;
  
  int get counterA => _counterA;
  int get counterB => _counterB;
  
  void incrementA() {
    _counterA++;
    notifyListeners();
  }
  
  void incrementB() {
    _counterB++;
    notifyListeners();
  }
}
