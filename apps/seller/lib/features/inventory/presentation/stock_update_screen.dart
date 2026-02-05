import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/seller_product.dart';
import '../../../core/state/product_provider.dart';

class StockUpdateScreen extends ConsumerWidget {
  const StockUpdateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(sellerProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Stock Update')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('In stock: ${product.stock}'),
            trailing: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _updateStock(ref, product, -1),
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: () => _updateStock(ref, product, 1),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _updateStock(WidgetRef ref, SellerProduct product, int delta) {
    final current = ref.read(sellerProductsProvider);
    final updated = [
      for (final item in current)
        if (item.id == product.id)
          SellerProduct(
            id: item.id,
            name: item.name,
            price: item.price,
            stock: (item.stock + delta).clamp(0, 9999),
          )
        else
          item,
    ];
    ref.read(sellerProductsProvider.notifier).state = updated;
  }
}
