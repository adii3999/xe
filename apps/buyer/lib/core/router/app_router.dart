import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/phone_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/location/presentation/location_screen.dart';
import '../../features/orders/presentation/order_tracking_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/products/presentation/product_list_screen.dart';
import '../../features/auth/state/auth_controller.dart';
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
        path: '/location',
        name: 'location',
        builder: (context, state) => const LocationScreen(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/orders/track',
        name: 'order_track',
        builder: (context, state) => const OrderTrackingScreen(),
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
