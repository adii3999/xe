import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

final cartProvider = StateNotifierProvider<CartController, List<CartItem>>(
  (ref) => CartController(),
);

class CartController extends StateNotifier<List<CartItem>> {
  CartController() : super(const []);

  void add(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      state = [...state, CartItem(product: product, quantity: 1)];
      return;
    }
    final updated = [...state];
    final current = updated[index];
    updated[index] = CartItem(product: current.product, quantity: current.quantity + 1);
    state = updated;
  }

  void remove(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;
    final updated = [...state];
    final current = updated[index];
    if (current.quantity <= 1) {
      updated.removeAt(index);
    } else {
      updated[index] = CartItem(product: current.product, quantity: current.quantity - 1);
    }
    state = updated;
  }

  int get total => state.fold(0, (sum, item) => sum + item.lineTotal);

  void clear() => state = const [];
}
