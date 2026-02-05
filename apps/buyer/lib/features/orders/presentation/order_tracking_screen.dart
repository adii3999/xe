import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/order_provider.dart';

class OrderTrackingScreen extends ConsumerWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Order Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.id,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text('Status: ${order.status}'),
            const SizedBox(height: 16),
            const LinearProgressIndicator(value: 0.7),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.store),
              title: Text('Shop packed the order'),
            ),
            const ListTile(
              leading: Icon(Icons.delivery_dining),
              title: Text('Rider picked up'),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('On the way to you'),
            ),
          ],
        ),
      ),
    );
  }
}
