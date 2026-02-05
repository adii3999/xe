import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/state/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer App'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/auth/phone');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'MVP Navigation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/location'),
              child: const Text('Location'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/products'),
              child: const Text('Nearby Products'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/cart'),
              child: const Text('Cart'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/orders/track'),
              child: const Text('Order Tracking'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
