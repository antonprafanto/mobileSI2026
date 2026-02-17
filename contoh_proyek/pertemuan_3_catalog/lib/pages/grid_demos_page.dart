import 'package:flutter/material.dart';

class GridDemosPage extends StatelessWidget {
  const GridDemosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GridView Demos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Count'),
              Tab(text: 'Builder'),
              Tab(text: 'Extent'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GridCountDemo(),
            GridBuilderDemo(),
            GridExtentDemo(),
          ],
        ),
      ),
    );
  }
}

class GridCountDemo extends StatelessWidget {
  const GridCountDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: List.generate(12, (index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        );
      }),
    );
  }
}

class GridBuilderDemo extends StatelessWidget {
  const GridBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, size: 48, color: Colors.grey[600]),
                const SizedBox(height: 8),
                Text('Item ${index + 1}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GridExtentDemo extends StatelessWidget {
  const GridExtentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: List.generate(15, (index) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.primaries[index % Colors.primaries.length],
                Colors.primaries[(index + 1) % Colors.primaries.length],
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Tile\n${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}
