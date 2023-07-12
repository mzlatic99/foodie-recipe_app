abstract class Auth<T> {
  T? get currentUser;

  Future<T> signInWithEmailAndPassword(String email, String password);

  Future<T> createUserWithEmailAndPassword(
      String name, String email, String password, String avatar);
}
