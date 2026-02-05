import 'cart_item.dart';

class Order {
  const Order({
    required this.id,
    required this.status,
    required this.items,
    required this.total,
  });

  final String id;
  final String status;
  final List<CartItem> items;
  final int total;
}
