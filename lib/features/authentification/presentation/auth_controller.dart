import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/router/app_router.dart';

import '../../../providers/providers.dart';
import '../../../router/app_route.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController({required this.ref}) : super(const AsyncLoading());
  final Ref ref;

  void signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
              email: email,
              password: password,
            ));
    if (state.hasError == false) {
      ref.read(goRouterProvider).pushNamed(AppRoute.home.name);
    }
  }

  void createUser(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
              email: email,
              password: password,
            ));
    if (state.hasError == false) {
      ref.read(goRouterProvider).pushNamed(AppRoute.home.name);
    }
  }

  Future<void> signOut() {
    final authRepository = ref.read(firebaseAuthProvider);
    return authRepository.signOut();
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref: ref);
});
