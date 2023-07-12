import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/services/storage/hive_storage_service.dart';
import '../../../constants/app_constants.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController({required this.ref}) : super(const AsyncLoading());
  final Ref ref;

  int selectedAvatarIndex = 0;

  void setSelectedAvatarIndex(int index) {
    selectedAvatarIndex = index;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password);

      if (user != null) {
        final hiveStorageService = HiveStorageService();
        hiveStorageService.user = user.uid;
        if (hiveStorageService.user != '') {
          hiveStorageService.openBox(StorageBox.favoritesBox);
          hiveStorageService.openBox(StorageBox.challengesBox);
          hiveStorageService.openBox(StorageBox.pointsBox);
          hiveStorageService.openBox(StorageBox.rewardsBox);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e.toString(), stack);
      return false;
    }
  }

  Future<bool> createUser(
      String name, String email, String password, String avatar) async {
    state = const AsyncValue.loading();
    final authRepository = ref.read(authRepositoryProvider);
    try {
      final user = await authRepository.createUserWithEmailAndPassword(
        name,
        email,
        password,
        avatar,
      );

      if (user != null) {
        final hiveStorageService = HiveStorageService();
        hiveStorageService.user = user.uid;
        if (hiveStorageService.user != '') {
          hiveStorageService.openBox(StorageBox.favoritesBox);
          hiveStorageService.openBox(StorageBox.challengesBox);
          hiveStorageService.openBox(StorageBox.pointsBox);
          hiveStorageService.openBox(StorageBox.rewardsBox);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e.toString(), stack);
      return false;
    }
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref: ref);
});
