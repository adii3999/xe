import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_client.dart';
import '../repositories/shop_repository.dart';

const _baseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:3000');

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(baseUrl: _baseUrl));

final shopRepositoryProvider = Provider<ShopRepository>(
  (ref) => ShopRepository(ref.read(apiClientProvider)),
);
