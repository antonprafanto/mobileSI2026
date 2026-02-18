# -*- coding: utf-8 -*-
"""Append Part 4 & Part 5 to Pertemuan 4 - Core Provider Implementation"""

part4_part5_content = """
## 🔔 PART 4: ChangeNotifier Pattern (25 menit)

### What is ChangeNotifier?

**ChangeNotifier** adalah class yang:
- Menyimpan state
- Notify listeners saat state berubah
- Pattern: **Observable** (observers listen to changes)

**💡 ANALOGI - ChangeNotifier seperti Alarm/Bell**:

```
Teacher (ChangeNotifier) has a bell 🔔
Students (Listeners) are working
When teacher rings bell → All students look up!

ChangeNotifier.notifyListeners() = Ring bell 🔔
Consumers = Students that listen
State change = New announcement
```

### ✏️ CODING BERSAMA: Counter with Provider (20 menit)

Mari rebuild counter app dengan Provider!

**Step 1: Create CounterModel** (5 menit)

Create folder `lib/models/` dan file `counter_model.dart`:

```dart
// lib/models/counter_model.dart
import 'package:flutter/foundation.dart';

class CounterModel extends ChangeNotifier {
  // 1. Private state variable
  int _count = 0;
  
  // 2. Public getter for read access
  int get count => _count;
  
  // 3. Public methods to modify state
  void increment() {
    _count++;                // Modify state
    notifyListeners();       // ← CRUCIAL! Notify all listeners
  }
  
  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
  
  void reset() {
    _count = 0;
    notifyListeners();
  }
  
  // Optional: method dengan parameter
  void addValue(int value) {
    _count += value;
    notifyListeners();
  }
}
```

**💡 PATTERN BREAKDOWN**:

```
┌────────────────────────────────────┐
│ class CounterModel                 │
│ extends ChangeNotifier             │ ← Magic!
├────────────────────────────────────┤
│ int _count = 0;                    │ ← Private state
│ int get count => _count;           │ ← Public getter (read-only)
├────────────────────────────────────┤
│ void increment() {                 │
│   _count++;                        │ ← Modify
│   notifyListeners();               │ ← Notify! 🔔
│ }                                  │
└────────────────────────────────────┘

Rule: ALWAYS call notifyListeners() after state change!
```

**Step 2: Provide at App Level** (3 menit)

Update `main.dart`:

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/counter_model.dart';
import 'pages/counter_provider_page.dart';

void main() {
  runApp(
    // Wrap MaterialApp with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => CounterModel(), // ← Create instance once
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterProviderPage(),
    );
  }
}
```

**💡 KEY POINTS**:
- `ChangeNotifierProvider` membuat CounterModel available ke semua widgets di bawahnya
- `create` function dipanggil ONCE saat app start
- Semua child widgets bisa akses CounterModel!

**Step 3: Consume with Consumer** (7 menit)

Create `lib/pages/counter_provider_page.dart`:

```dart
// lib/pages/counter_provider_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/counter_model.dart';

class CounterProviderPage extends StatelessWidget {
  const CounterProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('🔴 CounterProviderPage build'); // We'll see this ONCE
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter with Provider'),
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
            
            // Consumer - Only THIS widget rebuilds!
            Consumer<CounterModel>(
              builder: (context, counter, child) {
                print('🟢 Consumer rebuilt!'); // Only this prints on change
                return Text(
                  '${counter.count}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
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
                    // Use context.read to trigger action
                    context.read<CounterModel>().increment();
                  },
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterModel>().decrement();
                  },
                  child: const Text('Decrement'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterModel>().reset();
                  },
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
```

**Hot Reload!** Tap Increment → Counter updates!

**💡 WHAT HAPPENS**:

```
1. User taps "Increment" button
   ↓
2. context.read<CounterModel>().increment() called
   ↓
3. CounterModel._count++ executed
   ↓
4. notifyListeners() called
   ↓
5. All Consumers listening to CounterModel rebuild
   ↓
6. Only Consumer widget rebuilds, NOT entire page!
   ↓
7. UI shows new count value
```

**Step 4: Alternative - Using context.watch** (5 menit)

You can also use `context.watch` (simpler but rebuilds more):

```dart
// Alternative to Consumer
@override
Widget build(BuildContext context) {
  // Watch for changes - rebuilds ENTIRE widget
  final counter = context.watch<CounterModel>();
  
  return Scaffold(
    body: Center(
      child: Text('${counter.count}'),
    ),
  );
}
```

**Consumer vs context.watch**:

| Method | Rebuild Scope | Use Case |
|--------|---------------|----------|
| `Consumer` | Only Consumer widget | Targeted rebuild (better performance) |
| `context.watch` | Entire build method | Simple cases, small widgets |
| `context.read` | No rebuild | Callbacks, event handlers only |

### 🎯 EKSPERIMEN 4: Compare Rebuilds (5 menit)

**Test**: Add print statements dan lihat perbedaan!

```dart
// Using Consumer (BETTER)
Consumer<CounterModel>(
  builder: (context, counter, child) {
    print('Consumer rebuilt'); // ← Only this prints
    return Text('${counter.count}');
  },
)

// vs

// Using context.watch
final counter = context.watch<CounterModel>();
print('Entire widget rebuilt'); // ← Entire widget rebuilds!
return Text('${counter.count}');
```

**Result**: Consumer lebih efficient! Only rebuild what's needed.

> ⚠️ **TROUBLESHOOTING - ChangeNotifier**:
>
> **Problem**: "Could not find the correct Provider<CounterModel>"
> - **Cause**: ChangeNotifierProvider tidak di atas widget yang consume
> - **Fix**: Move ChangeNotifierProvider di main.dart, wrap MaterialApp
> - **Verify**: Provider harus di parent/ancestor dari Consumer
>
> **Problem**: "UI tidak update saat state berubah"
> - **Cause**: Lupa call `notifyListeners()`
> - **Fix**: Add `notifyListeners()` setelah every state change
> - **Pattern**: Always `_field++; notifyListeners();`
>
> **Problem**: "context.read used inside build method"
> - **Cause**: Trying to read inside build (should watch/Consumer)
> - **Fix**: Use `context.watch` or `Consumer` in build, `read` in callbacks
> - **Rule**: read = callbacks, watch = build

### 💡 Tips & Best Practices - ChangeNotifier

**DO ✅:**
- Extend ChangeNotifier untuk model classes
- Use private fields (`_count`) dengan public getters
- ALWAYS call notifyListeners() after state change
- Use Consumer untuk targeted rebuilds
- Use context.read di callbacks/event handlers
- Create separate model classes (not in widgets)

**DON'T ❌:**
- Don't forget notifyListeners() (most common mistake!)
- Don't use context.read inside build method
- Don't modify state without notifying
- Don't create multiple instances (use Provider)
- Don't dispose manually (Provider handles it)
- Don't call notifyListeners() in getter

**PATTERN TEMPLATE**:

```dart
class MyModel extends ChangeNotifier {
  // Private state
  Type _field = initialValue;
  
  // Public getter
  Type get field => _field;
  
  // Public methods
  void updateField(newValue) {
    _field = newValue;
    notifyListeners(); // ← ALWAYS!
  }
}
```

---

## 🛒 PART 5: Shopping Cart Hands-On (50 menit)

### 🎯 Project Goal

Build **Mini E-Commerce Shopping Cart** dengan Provider!

**Features Checklist**:
- [ ] Product model
- [ ] Cart model with ChangeNotifier
- [ ] Product list page
- [ ] Add to cart button
- [ ] Cart badge showing item count
- [ ] Cart page with all items
- [ ] Increase/decrease quantity
- [ ] Remove item button
- [ ] Total price calculation
- [ ] Empty cart message

### ✏️ CODING BERSAMA: Shopping Cart (45 menit)

**Step 1: Create Product Model** (5 menit)

```dart
// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
```

**Step 2: Create CartItem Model** (3 menit)

```dart
// lib/models/cart_item.dart
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  
  CartItem({
    required this.product,
    this.quantity = 1,
  });
  
  // Calculated property
  double get totalPrice => product.price * quantity;
}
```

**Step 3: Create CartModel with ChangeNotifier** (12 menit)

```dart
// lib/models/cart_model.dart
import 'package:flutter/foundation.dart';
import 'product.dart';
import 'cart_item.dart';

class CartModel extends ChangeNotifier {
  // Private state - Map for O(1) lookup
  final Map<String, CartItem> _items = {};
  
  // Getters
  Map<String, CartItem> get items => _items;
  
  List<CartItem> get itemsList => _items.values.toList();
  
  int get itemCount => _items.length;
  
  int get totalQuantity {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
  
  bool get isEmpty => _items.isEmpty;
  
  // Methods
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Product already in cart, increase quantity
      _items[product.id]!.quantity++;
    } else {
      // New product, add to cart
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners(); // ← Notify UI!
  }
  
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
  
  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }
  
  void decreaseQuantity(String productId) {
    if (!_items.containsKey(productId)) return;
    
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      // If quantity becomes 0, remove item
      _items.remove(productId);
    }
    notifyListeners();
  }
  
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
```

**💡 CODE EXPLANATION**:
- `Map<String, CarItem>` untuk fast lookup by product ID
- `fold()` untuk calculate totals efficiently
- Every method calls `notifyListeners()` after modifying state
- Getter tidak call notifyListeners (read-only!)

**Step 4: Update main.dart with CartModel Provider** (3 menit)

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}
```

**Step 5: Create Product List Page** (10 menit)

```dart
// lib/pages/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy products
    final products = [
      Product(
        id: '1',
        name: 'Laptop Gaming',
        price: 15000000,
        imageUrl: 'https://picsum.photos/seed/laptop/300',
        category: 'Electronics',
      ),
      Product(
        id: '2',
        name: 'Smartphone Pro', 
        price: 8000000,
        imageUrl: 'https://picsum.photos/seed/phone/300',
        category: 'Electronics',
      ),
      Product(
        id: '3',
        name: 'Wireless Headphones',
        price: 1500000,
        imageUrl: 'https://picsum.photos/seed/headphone/300',
        category: 'Audio',
      ),
      Product(
        id: '4',
        name: 'Smart Watch',
        price: 3000000,
        imageUrl: 'https://picsum.photos/seed/watch/300',
        category: 'Wearables',
      ),
      Product(
        id: '5',
        name: 'Camera DSLR',
        price: 12000000,
        imageUrl: 'https://picsum.photos/seed/camera/300',
        category: 'Photography',
      ),
      Product(
        id: '6',
        name: 'Tablet Pro',
        price: 7000000,
        imageUrl: 'https://picsum.photos/seed/tablet/300',
        category: 'Electronics',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          // Cart badge
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 50),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Add to cart using Provider!
                            context.read<CartModel>().addItem(product);
                            
                            // Show feedback
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} ditambahkan ke cart!'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_shopping_cart, size: 16),
                          label: const Text('Add', style: TextStyle(fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

**Hot Reload!** Product grid muncul + Cart badge works!

---

(To be continued in next script - Part 5 Step 6: Cart Page + Experiments + FAQ + Instructor section)
"""

# Append to file
with open('Pertemuan_4_State_Management_dengan_Provider.md', 'a', encoding='utf-8') as f:
    f.write(part4_part5_content)

print("✅ Part 4 & Part 5 (partial) appended successfully!")
print("Total new lines:", len(part4_part5_content.split('\n')))
print("\n📊 Added content:")
print("- 🔔 Part 4: ChangeNotifier Pattern (COMPLETE)")
print("  - Counter with Provider example")
print("  - Consumer vs watch vs read explanation")
print("  - Experiment 4 (Rebuild comparison)")
print("  - Troubleshooting box")
print("  - Tips & Best Practices")
print("- 🛒 Part 5: Shopping Cart (Steps 1-5)")
print("  - Product & CartItem models")
print("  - CartModel with full CRUD")
print("  - Product list page with cart badge")
print("  - Add to cart functionality")
print("\n⏳ Next: Cart Page + remaining sections...")
