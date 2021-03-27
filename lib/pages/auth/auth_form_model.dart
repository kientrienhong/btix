enum AuthFormType { signIn, register }

class AuthFormModel {
  final String email;
  final String password;
  final bool isLoading;
  final bool isFailed;
  final AuthFormType authFormType;
  AuthFormModel(
      {this.email = '',
      this.password = '',
      this.isLoading = false,
      this.isFailed = false,
      this.authFormType = AuthFormType.signIn});

  AuthFormModel copyWith(
      {String email,
      String password,
      AuthFormType authFormType,
      bool isLoading,
      bool isFailed}) {
    return AuthFormModel(
        email: email ?? this.email,
        authFormType: authFormType ?? this.authFormType,
        isLoading: isLoading ?? this.isLoading,
        password: password ?? this.password,
        isFailed: isFailed ?? this.isFailed);
  }
}
