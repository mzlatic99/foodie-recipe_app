import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/router/app_router.dart';
import '../../../router/app_route.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController({required this.ref}) : super(const AsyncLoading());
  final Ref ref;

  void signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).signInWithEmailAndPassword(
              email,
              password,
            ));
    if (state.hasError == false) {
      ref.read(goRouterProvider).replaceNamed(AppRoute.home.name);
    }
  }

  void createUser(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).createUserWithEmailAndPassword(
              email,
              password,
            ));
    if (state.hasError == false) {
      ref.read(goRouterProvider).replaceNamed(AppRoute.home.name);
    }
  }

  Future<void> signOut() {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.signOut();
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref: ref);
});
