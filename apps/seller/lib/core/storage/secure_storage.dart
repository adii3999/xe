import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _phoneKey = 'auth_phone';

  final FlutterSecureStorage _storage;

  Future<void> saveAuth({required String token, required String phone}) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _phoneKey, value: phone);
  }

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<String?> readPhone() => _storage.read(key: _phoneKey);

  Future<void> clearAuth() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _phoneKey);
  }
}
