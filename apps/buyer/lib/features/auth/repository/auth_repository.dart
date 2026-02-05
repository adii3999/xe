import '../../../core/network/api_client.dart';

class AuthRepository {
  AuthRepository(this._client);

  final ApiClient _client;

  Future<void> requestOtp(String phone) async {
    await _client.postJson('/api/v1/auth/otp/request', {'phone': phone});
  }

  Future<String> verifyOtp({required String phone, required String otp}) async {
    final json = await _client.postJson('/api/v1/auth/otp/verify', {
      'phone': phone,
      'otp': otp,
    });
    return json['token'] as String;
  }
}
