import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/order_controller.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(sellerOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              title: Text(order.id),
              subtitle: Text('${order.itemCount} items • ₹${order.total} • ${order.status}'),
              trailing: Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(sellerOrdersProvider.notifier).reject(order.id);
                    },
                    child: const Text('Reject'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(sellerOrdersProvider.notifier).accept(order.id);
                    },
                    child: const Text('Accept'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
