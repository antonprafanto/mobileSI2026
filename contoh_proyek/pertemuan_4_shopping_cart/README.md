# Pertemuan 4 - Shopping Cart with Provider

Full Flutter project demonstrating **State Management with Provider**.

## 🎯 Features

- ✅ Shopping cart with Provider (add, remove, quantity management)
- ✅ Real-time cart badge using Consumer
- ✅ MultiProvider setup (Cart + User + Theme)
- ✅ Dark/Light mode switching
- ✅ User profile with points system
- ✅ Learning demos: setState vs Provider comparison
- ✅ Selector optimization examples
- ✅ Provider methods comparison (read/watch/Consumer)
- ✅ Best practices guide

## 📂 Project Structure

```
lib/
├── main.dart                        # App with MultiProvider setup
├── models/
│   ├── product.dart                 # Product model
│   ├── cart_model.dart              # Cart with ChangeNotifier
│   ├── user_model.dart              # User state
│   └── theme_model.dart             # Theme state
├── data/
│   └── products_data.dart           # Sample products
├── pages/
│   ├── product_list_page.dart       # Main catalog
│   ├── cart_page.dart               # Shopping cart
│   ├── profile_page.dart            # User profile
│   ├── comparison_page.dart         # setState vs Provider
│   ├── selector_demo_page.dart      # Selector optimization
│   ├── provider_methods_page.dart   # Access methods comparison
│   └── best_practices_page.dart     # Do's and Don'ts
└── widgets/
    ├── product_card.dart            # Product card with add button
    ├── cart_badge.dart              # Badge with Consumer
    ├── cart_item_widget.dart        # Cart item row
    └── app_drawer.dart              # Navigation drawer
```

## 🚀 How to Run

1. Navigate to project:
   ```bash
   cd contoh_proyek/pertemuan_4_shopping_cart
   ```

2. Install provider:
   ```bash
   flutter pub add provider
   ```
   (Already done if you cloned)

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run:
   ```bash
   flutter run
   ```

## 📖 What You'll Learn

### Provider Concepts
- ✅ ChangeNotifier pattern
- ✅ ChangeNotifierProvider
- ✅ MultiProvider setup
- ✅ Consumer widget
- ✅ Selector for optimization
- ✅ context.read vs context.watch

### State Management Patterns
- ✅ Global app state
- ✅ Multiple providers
- ✅ Rebuild optimization
- ✅ Best practices

## 🎓 Learning Path

1. **Products Page**: Browse products, add to cart (see real-time badge)
2. **Cart Page**: Manage quantities, see total calculation
3. **Profile Page**: See MultiProvider in action (User + Cart)
4. **setState vs Provider**: Compare rebuild behavior (check console!)
5. **Selector Demo**: See performance optimization
6. **Provider Methods**: Learn read/watch/Consumer differences
7. **Best Practices**: Do's and Don'ts checklist

## 💡 Key Code Patterns

### MultiProvider setup:
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => CartModel()),
    ChangeNotifierProvider(create: (_) => UserModel()),
    ChangeNotifierProvider(create: (_) => ThemeModel()),
  ],
  child: MyApp(),
)
```

### Consumer:
```dart
Consumer<CartModel>(
  builder: (context, cart, child) {
    return Text('Items: ${cart.itemCount}');
  },
)
```

### Calling methods:
```dart
// In callbacks - NO rebuild
context.read<CartModel>().addItem(product);

// In build - REBUILDS
final count = context.watch<CartModel>().itemCount;
```

### Selector optimization:
```dart
Selector<CartModel, int>(
  selector: (context, cart) => cart.itemCount,
  builder: (context, count, child) {
    return Text('$count'); // Only rebuilds when itemCount changes
  },
)
```

## 🐛 Debugging Tips

- Check console logs for rebuild indicators
- Use Flutter DevTools to inspect widget tree
- Watch for unnecessary rebuilds
- Compare Consumer vs Selector performance

## 📝 Related Material

See [Pertemuan_4_State_Management_dengan_Provider.md](../../Pertemuan_4_State_Management_dengan_Provider.md)

---

**Dependencies**: provider ^6.1.0  
**Topic**: Pertemuan 4 - State Management with Provider
