import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/api_providers.dart';
import '../../../core/storage/secure_storage.dart';
import '../repository/auth_repository.dart';

class AuthState {
  const AuthState({this.phone, this.token, this.isLoading = false});

  final String? phone;
  final String? token;
  final bool isLoading;

  bool get isAuthed => token != null && token!.isNotEmpty;

  AuthState copyWith({String? phone, String? token, bool? isLoading}) {
    return AuthState(
      phone: phone ?? this.phone,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(apiClientProvider)),
);

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    ref.read(authRepositoryProvider),
    ref.read(secureStorageProvider),
  ),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._repo, this._storage) : super(const AuthState(isLoading: true)) {
    _restore();
  }

  final AuthRepository _repo;
  final SecureStorage _storage;

  Future<void> _restore() async {
    final token = await _storage.readToken();
    final phone = await _storage.readPhone();
    state = state.copyWith(token: token, phone: phone, isLoading: false);
  }

  Future<void> requestOtp(String phone) async {
    await _repo.requestOtp(phone);
    state = state.copyWith(phone: phone);
  }

  Future<void> verifyOtp(String otp) async {
    final phone = state.phone;
    if (phone == null || phone.isEmpty) {
      throw Exception('Phone not set');
    }
    final token = await _repo.verifyOtp(phone: phone, otp: otp);
    await _storage.saveAuth(token: token, phone: phone);
    state = state.copyWith(token: token);
  }

  void logout() {
    _storage.clearAuth();
    state = const AuthState();
  }
}
