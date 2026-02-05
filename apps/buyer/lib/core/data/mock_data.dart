import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/product.dart';

final productsMock = <Product>[
  const Product(id: 'p1', name: 'Fresh Milk', price: 60, shopName: 'Local Dairy'),
  const Product(id: 'p2', name: 'Bread', price: 40, shopName: 'Bakery Corner'),
  const Product(id: 'p3', name: 'Eggs (6)', price: 55, shopName: 'Daily Mart'),
  const Product(id: 'p4', name: 'Tomatoes 1kg', price: 70, shopName: 'Veggie Hub'),
  const Product(id: 'p5', name: 'Cooking Oil', price: 140, shopName: 'City Store'),
];

final orderMock = Order(
  id: 'ORD-12345',
  status: 'Out for delivery',
  items: const [
    CartItem(product: Product(id: 'p1', name: 'Fresh Milk', price: 60, shopName: 'Local Dairy'), quantity: 1),
    CartItem(product: Product(id: 'p2', name: 'Bread', price: 40, shopName: 'Bakery Corner'), quantity: 2),
  ],
  total: 140,
);
