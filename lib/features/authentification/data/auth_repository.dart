import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(FirebaseAuth.instance));

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => AuthRepository(FirebaseAuth.instance).authStateChanges);

class AuthRepository extends Auth {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  void Function(String)? onUserCreated;

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(code: e.code, message: 'User not found');
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(code: e.code, message: 'Wrong password');
      } else {
        throw FirebaseAuthException(
          code: e.code,
          message: e.code,
        );
      }
    }
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
    String name,
    String email,
    String password,
    String avatar,
  ) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await authResult.user?.updateDisplayName(name);
      await authResult.user?.updatePhotoURL(avatar);

      final user = authResult.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.updatePhotoURL(avatar);

        if (onUserCreated != null) {
          onUserCreated!(user.uid);
        }
      }

      return authResult.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;
}
