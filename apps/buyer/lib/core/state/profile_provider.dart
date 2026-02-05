import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/profile_repository.dart';
import 'authed_api_client.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.read(authedApiClientProvider)),
);

final profileProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return ref.read(profileRepositoryProvider).fetchProfile();
});
