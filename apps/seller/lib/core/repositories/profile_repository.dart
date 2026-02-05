import '../network/api_client.dart';

class ProfileRepository {
  ProfileRepository(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> fetchProfile() async {
    return _client.getJson('/api/v1/seller/profile');
  }
}
