import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/phone_screen.dart';
import '../../features/auth/state/auth_controller.dart';
import '../../features/earnings/presentation/earnings_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/inventory/presentation/stock_update_screen.dart';
import '../../features/orders/presentation/orders_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/products/presentation/product_add_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/auth/phone',
    routes: <GoRoute>[
      GoRoute(
        path: '/auth/phone',
        name: 'auth_phone',
        builder: (context, state) => const PhoneScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        name: 'auth_otp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/product/add',
        name: 'product_add',
        builder: (context, state) => const ProductAddScreen(),
      ),
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (context, state) => const StockUpdateScreen(),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/earnings',
        name: 'earnings',
        builder: (context, state) => const EarningsScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      if (auth.isLoading) return null;
      final isAuthRoute = state.fullPath?.startsWith('/auth') ?? false;
      if (!auth.isAuthed && !isAuthRoute) return '/auth/phone';
      if (auth.isAuthed && isAuthRoute) return '/';
      return null;
    },
  );
});
