import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../domain/auth.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
    (ref) => AuthRepository(FirebaseAuth.instance));

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
    } catch (e) {
      rethrow;
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
          await FirebaseChatCore.instance.createUserInFirestore(
            types.User(
              firstName: user.displayName,
              id: user.uid,
              imageUrl: user.photoURL,
            ),
          );
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

  @override
  User? get currentUser => _auth.currentUser;
}
