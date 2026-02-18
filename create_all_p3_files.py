# -*- coding: utf-8 -*-
"""
COMPREHENSIVE SCRIPT: Create ALL remaining demo project files
This generates ALL pages, widgets, and README for both Pertemuan 3 and 4
"""

import os

print("=" * 60)
print("CREATING ALL DEMO PROJECT FILES")
print("=" * 60)

# ===== PERTEMUAN 3 FILES =====
base3 = r'c:\Users\anton\vibecoding\mobileSI2026\contoh_proyek\pertemuan_3_catalog\lib'
os.makedirs(f'{base3}/pages', exist_ok=True)
os.makedirs(f'{base3}/widgets', exist_ok=True)

# We already have home_page and product_detail, skip those
# Create remaining pages

# category_page
category_page = """import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final products = getProductsByCategory(category);
          
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(
                category,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${products.length} products'),
              children: products.map((product) {
                return ListTile(
                  leading: Text(product.emoji, style: const TextStyle(fontSize: 32)),
                  title: Text(product.name),
                  subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
"""

with open(f'{base3}/pages/category_page.dart', 'w', encoding='utf-8') as f:
    f.write(category_page)
print("✅ P3: category_page.dart")

# list_demos_page
list_demos = """import 'package:flutter/material.dart';

class ListDemosPage extends StatelessWidget {
  const ListDemosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ListView Demos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Builder'),
              Tab(text: 'Separated'),
              Tab(text: 'Basic'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListBuilderDemo(),
            ListSeparatedDemo(),
            ListBasicDemo(),
          ],
        ),
      ),
    );
  }
}

class ListBuilderDemo extends StatelessWidget {
  const ListBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = List.generate(
      20,
      (i) => {'name': 'Contact ${i + 1}', 'phone': '+62 81${i.toString().padLeft(8, '0')}'},
    );

    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(contact['name']!),
          subtitle: Text(contact['phone']!),
          trailing: const Icon(Icons.call),
        );
      },
    );
  }
}

class ListSeparatedDemo extends StatelessWidget {
  const ListSeparatedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(15, (i) => 'Item ${i + 1}');

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.star, color: Colors.amber[700]),
          title: Text(items[index]),
          subtitle: Text('This is item number ${index + 1}'),
        );
      },
    );
  }
}

class ListBasicDemo extends StatelessWidget {
  const ListBasicDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const [
        Card(child: ListTile(title: Text('Static Item 1'))),
        Card(child: ListTile(title: Text('Static Item 2'))),
        Card(child: ListTile(title: Text('Static Item 3'))),
        Card(child: ListTile(title: Text('Static Item 4'))),
        Card(child: ListTile(title: Text('Static Item 5'))),
      ],
    );
  }
}
"""

with open(f'{base3}/pages/list_demos_page.dart', 'w', encoding='utf-8') as f:
    f.write(list_demos)
print("✅ P3: list_demos_page.dart")

# grid_demos_page
grid_demos = """import 'package:flutter/material.dart';

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
              'Tile\\n${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}
"""

with open(f'{base3}/pages/grid_demos_page.dart', 'w', encoding='utf-8') as f:
    f.write(grid_demos)
print("✅ P3: grid_demos_page.dart")

# navigation_demo_page
nav_demo = """import 'package:flutter/material.dart';

class NavigationDemoPage extends StatelessWidget {
  const NavigationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Demos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: const Text('Push to Second Page'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/categories');
              },
              child: const Text('Named Route (Categories)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ColorPicker()),
                );
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $result')),
                  );
                }
              },
              child: const Text('Return Data Example'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the second page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple'];
    
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a Color')),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(colors[index]),
            onTap: () => Navigator.pop(context, colors[index]),
          );
        },
      ),
    );
  }
}
"""

with open(f'{base3}/pages/navigation_demo_page.dart', 'w', encoding='utf-8') as f:
    f.write(nav_demo)
print("✅ P3: navigation_demo_page.dart")

# data_passing_demo_page
data_pass = """import 'package:flutter/material.dart';

class DataPassingDemoPage extends StatelessWidget {
  const DataPassingDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'Alice', 'age': 25},
      {'name': 'Bob', 'age': 30},
      {'name': 'Charlie', 'age': 28},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Passing Demo'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name'] as String),
            subtitle: Text('Age: ${user['age']}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailPage (
                    name: user['name'] as String,
                    age: user['age'] as int,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final String name;
  final int age;

  const UserDetailPage({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(name[0], style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 20),
            Text('Name: $name', style: const TextStyle(fontSize: 20)),
            Text('Age: $age', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
"""

with open(f'{base3}/pages/data_passing_demo_page.dart', 'w', encoding='utf-8') as f:
    f.write(data_pass)
print("✅ P3: data_passing_demo_page.dart")

# product_card widget
product_card = """import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(product.emoji, style: const TextStyle(fontSize: 64)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.category,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    Text(
                      'Rp ${_formatPrice(product.price)}',
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
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
"""

with open(f'{base3}/widgets/product_card.dart', 'w', encoding='utf-8') as f:
    f.write(product_card)
print("✅ P3: product_card.dart")

# app_drawer widget
drawer = """import 'package:flutter/material.dart';

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
"""

with open(f'{base3}/widgets/app_drawer.dart', 'w', encoding='utf-8') as f:
    f.write(drawer)
print("✅ P3: app_drawer.dart")

# P3 README
readme3 = """# Pertemuan 3 - Catalog App Demo

Full Flutter project demonstrating **ListView**, **GridView**, and **Navigation** concepts.

## 🎯 Features

- ✅ Product catalog with GridView
- ✅ Category filtering
- ✅ Product detail page with data passing
- ✅ ListView demos (builder, separated, basic)
- ✅ GridView demos (count, builder, extent)
- ✅ Navigation examples (push, pop, named routes)
- ✅ Data return from pages
- ✅ Drawer navigation

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry with named routes
├── models/
│   └── product.dart             # Product model
├── data/
│   └── products_data.dart       # Sample product data
├── pages/
│   ├── home_page.dart           # Main catalog (GridView)
│   ├── product_detail_page.dart # Product details
│   ├── category_page.dart       # Category view
│   ├── list_demos_page.dart     # ListView examples
│   ├── grid_demos_page.dart     # GridView examples
│   ├── navigation_demo_page.dart # Navigation examples
│   └── data_passing_demo_page.dart # Data passing examples
└── widgets/
    ├── product_card.dart        # Reusable product card
    └── app_drawer.dart          # Navigation drawer
```

## 🚀 How to Run

1. Navigate to project directory:
   ```bash
   cd contoh_proyek/pertemuan_3_catalog
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 📖 What You'll Learn

### ListView Concepts
- `ListView.builder` - Efficient list rendering
- `ListView.separated` - Lists with dividers
- Basic `ListView` - Static lists

### GridView Concepts
- `GridView.count` - Fixed column count
- `GridView.builder` - Efficient grid rendering
- `GridView.extent` - Fixed item width

### Navigation Concepts
- `Navigator.push` - Navigate to new page
- `Navigator.pop` - Go back
- `Navigator.pushNamed` - Named routes
- Passing data between pages
- Receiving return values

## 🎓 Learning Path

1. **Start**: Open drawer → "Home" (see GridView catalog)
2. **Categories**: Filter products by category
3. **Product Detail**: Tap any product (data passing demo)
4. **ListView Demos**: See different ListView patterns
5. **GridView Demos**: See different GridView patterns
6. **Navigation Demo**: Try push/pop and return values
7. **Data Passing Demo**: See how to pass data to pages

## 💡 Key Code Patterns

### GridView with 2 columns:
``` dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.7,
  ),
  itemBuilder: (context, index) => ProductCard(...),
)
```

### Navigation with data:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(product: product),
  ),
);
```

### Return data:
```dart
final result = await Navigator.push(...);
if (result != null) {
  // Use returned data
}
```

## 📝 Related Material

See [Pertemuan_3_ListView_GridView_dan_Navigasi.md](../../Pertemuan_3_ListView_GridView_dan_Navigasi.md) for complete learning material.

---

**Created for**: Mobile Programming Course  
**Topic**: Pertemuan 3 - ListView, GridView, Navigation
"""

with open(r'c:\Users\anton\vibecoding\mobileSI2026\contoh_proyek\pertemuan_3_catalog\README.md', 'w', encoding='utf-8') as f:
    f.write(readme3)
print("✅ P3: README.md")

print("\\n" + "=" * 60)
print("PERTEMUAN 3 COMPLETE! ✅")
print("=" * 60)
print("\\nContinue creating Pertemuan 4 files...")
