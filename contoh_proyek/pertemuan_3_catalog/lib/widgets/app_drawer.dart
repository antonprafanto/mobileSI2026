import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.store, size: 50, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Catalog App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () => Navigator.pushNamed(context, '/categories'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('ListView Demos'),
            onTap: () => Navigator.pushNamed(context, '/list-demos'),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('GridView Demos'),
            onTap: () => Navigator.pushNamed(context, '/grid-demos'),
          ),
          ListTile(
            leading: const Icon(Icons.navigation),
            title: const Text('Navigation Demo'),
            onTap: () => Navigator.pushNamed(context, '/navigation-demo'),
          ),
          ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Data Passing Demo'),
            onTap: () => Navigator.pushNamed(context, '/data-passing-demo'),
          ),
        ],
      ),
    );
  }
}
