import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import 'api_providers.dart';

final asyncProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(shopRepositoryProvider);
  return repo.fetchNearbyProducts();
});
