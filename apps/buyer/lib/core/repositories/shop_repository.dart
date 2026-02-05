import '../models/product.dart';
import '../network/api_client.dart';

class ShopRepository {
  ShopRepository(this._client);

  final ApiClient _client;

  Future<List<Product>> fetchNearbyProducts() async {
    final json = await _client.getJson('/api/v1/shops/nearby');
    final items = (json['items'] as List<dynamic>? ?? []);
    return items
        .map((item) => Product(
              id: item['id'] as String,
              name: item['name'] as String,
              price: item['price'] as int,
              shopName: item['shopName'] as String,
            ))
        .toList();
  }
}
