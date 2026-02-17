import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.shopping_bag, size: 50, color: Colors.white),
                SizedBox(height: 16),
                Text('Shopping Cart', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Products'),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () => Navigator.pushNamed(context, '/cart'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Learning Demos', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.compare),
            title: const Text('setState vs Provider'),
            onTap: () => Navigator.pushNamed(context, '/comparison'),
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Selector Optimization'),
            onTap: () => Navigator.pushNamed(context, '/selector-demo'),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Provider Methods'),
            onTap: () => Navigator.pushNamed(context, '/provider-methods'),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Best Practices'),
            onTap: () => Navigator.pushNamed(context, '/best-practices'),
          ),
          const Divider(),
          Consumer<ThemeModel>(
            builder: (context, theme, child) {
              return SwitchListTile(
                secondary: Icon(theme.isDark ? Icons.dark_mode : Icons.light_mode),
                title: const Text('Dark Mode'),
                value: theme.isDark,
                onChanged: (value) => theme.toggleTheme(),
              );
            },
          ),
        ],
      ),
    );
  }
}
