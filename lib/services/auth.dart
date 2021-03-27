abstract class AuthBase {
  Future<void> signInUserName(String username, String password);
}

class Auth implements AuthBase {
  @override
  Future<void> signInUserName(String username, String password) {}
}
