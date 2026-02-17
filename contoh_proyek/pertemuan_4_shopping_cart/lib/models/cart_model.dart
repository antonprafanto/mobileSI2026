// lib/models/cart_model.dart
import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  int get totalQuantity => _items.values.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalPrice => _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
    debugPrint('✅ Added ${product.name} to cart');
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
    debugPrint('🗑️ Removed item from cart');
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
      debugPrint('➕ Increased quantity');
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items[productId]!.quantity--;
        notifyListeners();
        debugPrint('➖ Decreased quantity');
      } else {
        removeItem(productId);
      }
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
    debugPrint('🧹 Cart cleared');
  }
}
