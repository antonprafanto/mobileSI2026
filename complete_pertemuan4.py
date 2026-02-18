# -*- coding: utf-8 -*-
"""Complete Pertemuan 4 - Cart Page, Advanced Topics, FAQ, Instructor Section"""

final_content = """
**Step 6: Create Cart Page** (12 menit)

```dart
// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          // Clear cart button
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return cart.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        // Show confirmation dialog
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Clear Cart?'),
                            content: const Text('Remove all items from cart?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<CartModel>().clear();
                                  Navigator.pop(ctx);
                                },
                                child: const Text('Clear'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Continue Shopping'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.itemsList.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.itemsList[index];
                    final product = cartItem.product;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            // Product image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Product info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${product.price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Quantity controls
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cart.decreaseQuantity(product.id);
                                        },
                                        icon: const Icon(Icons.remove_circle_outline),
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          '${cartItem.quantity}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          cart.increaseQuantity(product.id);
                                        },
                                        icon: const Icon(Icons.add_circle_outline),
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Remove button & subtotal
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cart.removeItem(product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${product.name} removed'),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                                Text(
                                  'Rp ${cartItem.totalPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Total price bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Rp ${cart.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Checkout action
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Checkout'),
                              content: Text(
                                'Total: Rp ${cart.totalPrice.toStringAsFixed(0)}\\nItems: ${cart.totalQuantity}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cart.clear();
                                    Navigator.pop(ctx);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Order placed!')),
                                    );
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

**Hot Reload & Test!** Full shopping cart working! 🎉

### 🎯 EKSPERIMEN 5: Test Cart Operations (5 menit)

**Try these operations**:

1. Add product 3x → Quantity should be 3 ✓
2. Add different products → Badge shows count ✓
3. Increase quantity → Updates price ✓
4. Decrease to 1 → Still in cart ✓
5. Decrease to 0 → Removed from cart ✓
6. Clear all → Empty cart message ✓
7. Navigate back → Badge still correct ✓

**No prop drilling! All pages access same CartModel!** 🎉

---

## 🚀 PART 6: Advanced Provider Topics (15 menit)

### Topic 1: MultiProvider (4 menit)

Kalau app punya multiple state objects:

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: const MyApp(),
    ),
  );
}
```

**Akses semua providers**:

```dart
final cart = context.watch<CartModel>();
final user = context.watch<UserModel>();
final theme = context.watch<ThemeModel>();
```

### Topic 2: Consumer vs context.watch vs context.read (6 menit)

**Comparison Table**:

| Method | Rebuild | Use in build() | Use in callback | Best For |
|--------|---------|----------------|-----------------|----------|
| **Consumer** | ✅ Yes (optimized) | ✅ Yes | ❌ No | Specific widget rebuild |
| **context.watch** | ✅ Yes (entire widget) | ✅ Yes | ❌ No | Simple cases |
| **context.read** | ❌ No | ❌ No | ✅ Yes | Triggering actions |

**Examples**:

```dart
// 1. Consumer - Best for targeted rebuilds
Consumer<CartModel>(
  builder: (context, cart, child) {
    return Text('Items: ${cart.itemCount}');
  },
)

// 2. context.watch - Simple but less efficient
@override
Widget build(BuildContext context) {
  final cart = context.watch<CartModel>();
  return Text('Items: ${cart.itemCount}');
}

// 3. context.read - For callbacks ONLY
ElevatedButton(
  onPressed: () {
    context.read<CartModel>().clear(); // ✓ Correct
  },
)

// ❌ WRONG - Don't use read in build
@override
Widget build(BuildContext context) {
  final cart = context.read<CartModel>(); // ❌ Error!
  return Text('${cart.itemCount}');
}
```

### Topic 3: Selector - Performance Optimization (5 menit)

**Problem**: Consumer rebuilds even if you only need one field!

**Solution**: Use `Selector`!

```dart
// Rebuild only when itemCount changes, NOT totalPrice
Selector<CartModel, int>(
  selector: (context, cart) => cart.itemCount,
  builder: (context, itemCount, child) {
    return Text('Items: $itemCount');
  },
)
```

**When to use**:
- Large model with many fields
- Widget only needs specific field
- Frequent updates to model

### 💡 Tips & Best Practices - Provider Optimization

**DO ✅:**
- Use Consumer for targeted rebuilds
- Use context.read in callbacks
- Use Selector when model is large
- Use MultiProvider for multiple models
- Keep models focused (single responsibility)

**DON'T ❌:**
- Don't use context.read inside build
- Don't forget notifyListeners
- Don't create Provider below MaterialApp (usually)
- Don't use context.watch in callbacks

> ⚠️ **TROUBLESHOOTING - Advanced Provider**:
>
> **Problem**: "Bad state: No ChangeNotifierProvider found"
> - **Cause**: Using Provider context above MaterialApp
> - **Fix**: Use Builder or separate widget
>
> **Problem**: "Too many rebuilds / Performance slow"
> - **Cause**: Using context.watch instead of Consumer
> - **Fix**: Use Consumer for specific widgets
> - **Or**: Use Selector for single fields
>
> **Problem**: "Selector not updating"
> - **Cause**: Selector returning same object reference
> - **Fix**: Return primitive (int, String) or override `==`

---

## 🎯 PART 7: Wrap Up & Review (5 menit)

### ✅ Yang Sudah Dipelajari

1. **Ephemeral vs App State** - Local vs shared state
2. **setState Limitations** - Prop drilling problem
3. **Provider Package** - Official state management
4. **ChangeNotifier Pattern** - Observable state
5. **Consumer / watch / read** - Different access methods
6. **Shopping Cart** - Real-world implementation

### 🏆 Achievement Unlocked

- ✅ Bisa explain setState limitations (prop drilling)
- ✅ Bisa create ChangeNotifier class dari scratch
- ✅ Bisa setup Provider di app level
- ✅ Bisa consume state dengan Consumer
- ✅ Bisa update state dengan context.read
- ✅ Working shopping cart app! 🛒

### 📝 Tugas Rumah - Shopping Cart Enhancement

**WAJIB (70 points)**:
1. ✓ Add to cart from product list
2. ✓ Show cart items dengan quantity
3. ✓ Update quantity (+/-)
4. ✓ Remove items from cart
5. ✓ Display total price correctly

**BONUS (+30 points)**:
1. **Search/Filter** (+10) - Search products by name
2. **Categories** (+10) - Filter products by category
3. **Checkout Page** (+10) - Order summary + form

**Deadline**: H+7 (Submit via GitHub)

---

## ❓ FAQ - Frequently Asked Questions

### Q1: Kapan pakai setState vs Provider?

**A**: 
- **setState** → State LOCAL ke 1 widget (form input, toggle, simple counter)
- **Provider** → State SHARED antar >2 widgets (cart, user, theme)

**Rule**: Kalau >2 widgets perlu same data → Provider!

### Q2: Apa bedanya ChangeNotifier vs StreamController?

**A**:
- **ChangeNotifier** → For state management (simpler, recommended)
- **StreamController** → For async data streams (complex events)

Provider uses ChangeNotifier internally (easier API).

### Q3: Kenapa Provider lebih baik dari InheritedWidget?

**A**: Provider IS InheritedWidget + extra features:
- ✅ Lazy loading
- ✅ Dispose management
- ✅ Better API (Consumer, watch, read)
- ✅ MultiProvider support
- ✅ Official recommendation

### Q4: Bagaimana cara multiple providers?

**A**: Use `MultiProvider`!

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => CartModel()),
    ChangeNotifierProvider(create: (_) => UserModel()),
  ],
  child: MyApp(),
)
```

### Q5: Apa bedanya Consumer, context.watch, dan context.read?

**A**:

| | Consumer | watch | read |
|---|---|---|---|
| **Rebuild** | ✅ Specific widget | ✅ Entire widget | ❌ No |
| **In build** | ✅ Yes | ✅ Yes | ❌ No |
| **In callback** | ❌ No | ❌ No | ✅ Yes |

**Use**: Consumer (targeted), watch (simple), read (callbacks).

### Q6: Bagaimana cara test code yang pakai Provider?

**A**: Inject mock Provider in tests:

```dart
testWidgets('Cart test', (tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => MockCartModel(), // Mock!
      child: MyApp(),
    ),
  );
});
```

### Q7: Bisa pakai Provider dengan StatelessWidget?

**A**: YES! Provider works dengan StatelessWidget:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Text('${cart.itemCount}');
  }
}
```

No need StatefulWidget untuk Provider!

### Q8: Apakah Provider cukup untuk app besar?

**A**: 

For **most apps** → YES! Provider sufficient.

Consider alternatives when:
- Very complex state logic → **Bloc**
- Many async operations → **Riverpod**
- Enterprise scale → **Bloc** + **Clean Architecture**

**Recommendation**: Start Provider, upgrade kalau perlu!

---

## 👨‍🏫 FOR INSTRUCTORS ONLY

> 📌 Instruksi untuk Dosen/Instruktur

### Persiapan Sebelum Kelas (30 menit)

1. **Test All Code**
   - Run counter demo
   - Run shopping cart
   - Verify Provider package installed
   - Test on physical device

2. **Prepare Materials**
   - Prop drilling slides/diagram
   - Provider flow diagram
   - Shopping cart wireframe

3. **Setup Classroom**
   - Projector tested
   - Sample apps running
   - WiFi stable for pub get

### Timeline Management (STRICT 150 min)

**Cannot skip**:
- Part 0: 10 min (quiz bisa shortened)
- Part 1: 15 min (core concepts)
- Part 2: 20 min (show the problem!)
- Part 4: 25 min (ChangeNotifier basics)
- Part 5: 50 min (main project)

**Can adjust**:
- Part 3: 10 min → 7 min (skip history)
- Part 6: 15 min → 10 min (skip Selector)
- Part 7: 5 min → 3 min (quick review)

**If running late**: Skip Part 6 entirely, focus on working cart.

### Common Student Mistakes

1. **Forgot notifyListeners()** - MOST COMMON!
   - Symptom: State changes but UI doesn't update
   - Fix: Check every method calls notifyListeners()

2. **context.read in build method**
   - Error: "Don't use read inside build"
   - Fix: Use watch or Consumer

3. **Provider not in ancestor**
   - Error: "Could not find Provider"
   - Fix: Check ChangeNotifierProvider wraps widget

4. **Multiple Provider instances**
   - Problem: Each page has own cart
   - Fix: Provider in main.dart ONCE

5. **Disposed ChangeNotifier**
   - Error: after dispose
   - Fix: Provider handles dispose automatically

### Grading Praktikum (100 points)

| Kriteria | Weight | Details |
|----------|--------|---------|
| **CartModel** | 25% | ChangeNotifier, add/remove/update, getters, notifyListeners |
| **Product List** | 20% | Display, add to cart, badge updates |
| **Cart Page** | 25% | Show items, quantity controls, remove, total |
| **Navigation** | 15% | Badge, navigate to cart, data persists |
| **Code Quality** | 15% | Clean, no warnings, proper naming |

**Bonus** (+20):
- Clear cart (+5)
- Search (+10)
- Checkout flow (+5)

### Discussion Prompts

- "Aplikasi favorit kalian yang punya shopping cart?"
- "Kenapa Instagram/Twitter perlu state management?"
- "Bedanya refresh feed vs update cart?"

### Differentiation

**Fast learners**:
- Implement search/filter
- Add product categories
- Persistent cart (SharedPreferences)
- Checkout with form

**Struggling students**:
- Provide skeleton code
- Focus on add/remove only (skip quantity)
- Pair programming
- Reference solution available

---

**🎉 Pertemuan 4 Complete!**

**Next**: Pertemuan 5 - Forms, Validasi & Debugging
"""

# Append final content
with open('Pertemuan_4_State_Management_dengan_Provider.md', 'a', encoding='utf-8') as f:
    f.write(final_content)

print("✅ PERTEMUAN 4 COMPLETE!")
print("File: Pertemuan_4_State_Management_dengan_Provider.md")
print("\n📊 Final content added:")
print("- 🛒 Part 5 Step 6: Cart Page (complete)")
print("- 🎯 Experiment 5: Test cart operations")
print("- 🚀 Part 6: Advanced Topics")
print("  - MultiProvider")
print("  - Consumer vs watch vs read (table)")
print("  - Selector optimization")
print("  - Tips & Troubleshooting")
print("- 🎯 Part 7: Wrap Up & Review")
print("  - Learning summary")
print("  - Achievement checklist")
print("  - Homework (wajib + bonus)")
print("- ❓ FAQ: 8 comprehensive Q&As")
print("- 👨‍🏫 Instructor Section")
print("  - Preparation guide")
print("  - Timeline management")
print("  - Common mistakes")
print("  - Grading rubric")
print("  - Differentiation strategies")

print("\n🎉 ALL SECTIONS COMPLETE!")

# Count total lines
with open('Pertemuan_4_State_Management_dengan_Provider.md', 'r', encoding='utf-8') as f:
    content = f.read()
    total_lines = len(content.split('\n'))
    
print(f"\n📏 Total lines: {total_lines}")
print(f"📦 File size: {len(content)} characters")

# Verify emoji
emoji_check = {
    '📱': '📱 PERTEMUAN' in content,
    '🎯': '🎯 Tujuan' in content,
    '✅': '✅ Menjelaskan' in content,
    '🛒': '🛒 PART 5' in content,
    '💡': '💡 ANALOGI' in content,
    '⚠️': '⚠️ **TROUBLESHOOTING' in content,
    '✏️': '✏️ CODING BERSAMA' in content,
}

print("\n📊 Emoji verification:")
for emoji, found in emoji_check.items():
    status = "✓" if found else "✗"
    print(f"  {status} {emoji}: {found}")

print("\n✅ Material ready for deployment!")
