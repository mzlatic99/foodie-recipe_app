import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api/dio_service.dart';
import '../services/storage/hive_storage_service.dart';
import '../services/storage/storage_service.dart';

final dioServiceProvider = Provider<DioService>((ref) => DioService(ref));

final onBoardingPageProvider = StateProvider<int>((ref) => 0);

final storageServiceProvider = Provider<StorageService>((ref) {
  return HiveStorageService();
});

final ingredientMultiplierProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

final instructionsCounterProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

final homeScrollProvider = StateProvider<bool>((ref) => false);
