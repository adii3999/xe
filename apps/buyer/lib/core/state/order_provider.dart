import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_data.dart';
import '../models/order.dart';

final orderProvider = Provider<Order>((ref) => orderMock);
