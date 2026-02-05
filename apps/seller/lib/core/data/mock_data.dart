import '../models/earnings.dart';
import '../models/seller_order.dart';
import '../models/seller_product.dart';

final sellerProductsMock = <SellerProduct>[
  const SellerProduct(id: 'sp1', name: 'Milk', price: 60, stock: 12),
  const SellerProduct(id: 'sp2', name: 'Bread', price: 40, stock: 18),
  const SellerProduct(id: 'sp3', name: 'Eggs (6)', price: 55, stock: 9),
  const SellerProduct(id: 'sp4', name: 'Tomatoes 1kg', price: 70, stock: 14),
];

final sellerOrdersMock = <SellerOrder>[
  const SellerOrder(id: 'ORD-201', itemCount: 2, total: 199, status: 'New'),
  const SellerOrder(id: 'ORD-202', itemCount: 1, total: 99, status: 'New'),
  const SellerOrder(id: 'ORD-203', itemCount: 3, total: 249, status: 'Accepted'),
  const SellerOrder(id: 'ORD-204', itemCount: 1, total: 59, status: 'Rejected'),
];

final earningsMock = Earnings(today: 1250, week: 7850);
