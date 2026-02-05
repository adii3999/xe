import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_data.dart';
import '../models/earnings.dart';

final earningsProvider = Provider<Earnings>((ref) => earningsMock);
