import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_data.dart';
import '../models/seller_product.dart';

final sellerProductsProvider = StateProvider<List<SellerProduct>>(
  (ref) => List<SellerProduct>.from(sellerProductsMock),
);
