import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_data.dart';
import '../models/seller_order.dart';

final sellerOrdersProvider = StateNotifierProvider<SellerOrdersController, List<SellerOrder>>(
  (ref) => SellerOrdersController(),
);

class SellerOrdersController extends StateNotifier<List<SellerOrder>> {
  SellerOrdersController() : super(List<SellerOrder>.from(sellerOrdersMock));

  void accept(String id) {
    _updateStatus(id, 'Accepted');
  }

  void reject(String id) {
    _updateStatus(id, 'Rejected');
  }

  void _updateStatus(String id, String status) {
    state = [
      for (final order in state)
        if (order.id == id)
          SellerOrder(
            id: order.id,
            itemCount: order.itemCount,
            total: order.total,
            status: status,
          )
        else
          order,
    ];
  }
}
