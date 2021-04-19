enum AuthFormType { signIn, register }

class AuthFormModel {
  final bool isLoading;
  final String errorMsg;
  final bool isFailed;
  final AuthFormType authFormType;
  AuthFormModel(
      {this.isLoading = false,
      this.errorMsg = '',
      this.isFailed = false,
      this.authFormType = AuthFormType.signIn});

  AuthFormModel copyWith(
      {AuthFormType authFormType,
      bool isLoading,
      bool isFailed,
      String errorMsg}) {
    return AuthFormModel(
        errorMsg: errorMsg ?? this.errorMsg,
        authFormType: authFormType ?? this.authFormType,
        isLoading: isLoading ?? this.isLoading,
        isFailed: isFailed ?? this.isFailed);
  }
}
