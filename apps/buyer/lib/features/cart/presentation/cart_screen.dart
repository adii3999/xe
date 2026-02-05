import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/cart_controller.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: items.isEmpty
            ? const Center(child: Text('Cart is empty.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text('Qty ${item.quantity} • ₹${item.product.price}'),
                          trailing: Text('₹${item.lineTotal}'),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total: ₹$total',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order placed (mock).')),
                      );
                    },
                    child: const Text('Place order'),
                  ),
                ],
              ),
      ),
    );
  }
}
