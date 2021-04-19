class Validation {
  static String validatorEmail(String email) {
    if (email.isEmpty) {
      return 'Please input email';
    }

    return null;
  }

  static String validatorPassword(String password) {
    if (password.isEmpty) {
      return 'Please input password';
    }

    return null;
  }
}
