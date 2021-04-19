import 'dart:async';
import 'package:btix/apis/api.dart';
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
      {bool isLoading,
      bool isFailure,
      AuthFormType authFormType,
      String error}) {
    _model = _model.copyWith(
        authFormType: authFormType,
        isLoading: isLoading,
        isFailed: isFailure,
        errorMsg: error);

    _modelController.add(_model);
  }

  Future<bool> logIn(
      {@required String username, @required String password}) async {
    updateWith(isLoading: true);
    try {
      await authBase.signInUserName(username, password);
      updateWith(isFailure: false);
      return true;
    } catch (e) {
      print(e.toString());
      updateWith(isFailure: true, error: 'Invalid username/password!');
      return false;
    } finally {
      updateWith(isLoading: false);
    }
  }

  Future<bool> signUp(@required String username, @required String password,
      @required String confirm) async {
    updateWith(isLoading: true);
    try {
      if (password != confirm) {
        updateWith(error: 'Password must match with confirm', isFailure: true);
        return false;
      }

      await Api.signUp(username, password);
      return true;
    } catch (e) {
      print(e.toString());
      updateWith(error: 'Username \'s existed!', isFailure: true);
      return false;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void toggleForm(
      AnimationController controller,
      AuthFormType current,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) async {
    if (current == _model.authFormType) {
      return;
    }
    emailController.clear();
    passwordController.clear();
    confirmPasswordController?.clear();
    AuthFormType formType = _model.authFormType == AuthFormType.register
        ? AuthFormType.signIn
        : AuthFormType.register;

    if (formType == AuthFormType.register) {
      await controller.forward();
    } else {
      await controller.reverse();
    }

    updateWith(authFormType: formType, isFailure: false);
  }
}
