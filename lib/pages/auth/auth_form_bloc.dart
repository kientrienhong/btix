import 'dart:async';
import 'package:flutter/material.dart';
import 'package:btix/pages/auth/auth_form_model.dart';
import 'package:btix/services/auth.dart';

class AuthFormBloc {
  var _modelController = StreamController<AuthFormModel>();

  AuthBase authBase;
  AuthFormBloc({@required this.authBase});
  Stream<AuthFormModel> get modelStream => _modelController.stream;
  AuthFormModel _model = AuthFormModel();
  void dipose() {
    _modelController.close();
  }

  void updateWith(
      {String email,
      String password,
      bool isLoading,
      bool isFailure,
      AuthFormType authFormType}) {
    _model = _model.copyWith(
        email: email,
        authFormType: authFormType,
        isLoading: isLoading,
        password: password,
        isFailed: isFailure);

    _modelController.add(_model);
  }

  void toggleForm(AnimationController controller, AuthFormType current) async {
    if (current == _model.authFormType) {
      return;
    }

    AuthFormType formType = _model.authFormType == AuthFormType.register
        ? AuthFormType.signIn
        : AuthFormType.register;

    if (formType == AuthFormType.register) {
      await controller.forward();
    } else {
      await controller.reverse();
    }

    updateWith(authFormType: formType);
  }
}
