typedef Uid = String;

class AppUser {
  const AppUser(this.email, {required this.uid});

  final Uid uid;
  final String email;
}
