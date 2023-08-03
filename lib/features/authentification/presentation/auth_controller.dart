import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/providers/providers.dart';

import '../../../constants/storage_box_constants.dart';
import '../../challenges/domain/challenge.dart';
import '../../recipes/domain/recipe.dart';
import '../../rewards/domain/reward.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController({
    required this.authRepository,
    required this.ref,
  }) : super(const AsyncData<void>(null));
  final AuthRepository authRepository;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Ref ref;

  int selectedAvatarIndex = 0;

  void setSelectedAvatarIndex(int index) {
    selectedAvatarIndex = index;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await authRepository.signInWithEmailAndPassword(email, password);
    });
    final user = authRepository.currentUser;
    final hiveStorageService = ref.watch(storageServiceProvider);
    if (user != null) {
      hiveStorageService.user = user.email!;
      if (!hiveStorageService.isBoxOpen(StorageBox.favoritesBox)) {
        await hiveStorageService.openBox<Recipe>(StorageBox.favoritesBox);
      }
      if (!hiveStorageService.isBoxOpen(StorageBox.challengesBox)) {
        await hiveStorageService.openBox<Challenge>(StorageBox.challengesBox);
      }
      if (!hiveStorageService.isBoxOpen(StorageBox.pointsBox)) {
        await hiveStorageService.openBox<int>(StorageBox.pointsBox);
      }
      if (!hiveStorageService.isBoxOpen(StorageBox.rewardsBox)) {
        await hiveStorageService.openBox<Reward>(StorageBox.rewardsBox);
      }
    }
    return state.hasError == false;
  }

  Future<bool> createUser(
      String name, String email, String password, String avatar) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await authRepository.createUserWithEmailAndPassword(
        name,
        email,
        password,
        avatar,
      ),
    );
    final user = authRepository.currentUser;
    final hiveStorageService = ref.watch(storageServiceProvider);
    if (user != null) {
      final data = {
        'name': user.displayName ?? user.email,
        'date_time': DateTime.now(),
        'email': user.email,
        'avatar': user.photoURL
      };
      try {
        firestore.collection('Users').doc(user.uid).set(data);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      hiveStorageService.user = user.email!;
      if (!hiveStorageService.isBoxOpen(StorageBox.favoritesBox)) {
        await hiveStorageService.openBox<Recipe>(StorageBox.favoritesBox);
      }
      if (!hiveStorageService.isBoxOpen(StorageBox.challengesBox)) {
        await hiveStorageService.openBox<Challenge>(StorageBox.challengesBox);
      }
      if (!hiveStorageService.isBoxOpen(StorageBox.pointsBox)) {
        await hiveStorageService.openBox<int>(StorageBox.pointsBox);
      }
      if (!hiveStorageService.isBoxOpen(StorageBox.rewardsBox)) {
        await hiveStorageService.openBox<Reward>(StorageBox.rewardsBox);
      }
    }
    return state.hasError == false;
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) {
  return AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  );
});
