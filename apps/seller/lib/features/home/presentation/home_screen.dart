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
        title: const Text('Seller App'),
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
              onPressed: () => context.go('/product/add'),
              child: const Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/inventory'),
              child: const Text('Stock Update'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/orders'),
              child: const Text('Orders'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/earnings'),
              child: const Text('Earnings'),
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
