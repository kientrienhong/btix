import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/pages/auth/auth_form_bloc.dart';
import 'package:btix/pages/auth/auth_form_model.dart';
import 'package:btix/pages/auth/auth_text_form.dart';
import 'package:btix/pages/home/home_page.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final AuthFormBloc bloc;
  AuthForm({this.bloc});
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final bloc = AuthFormBloc(authBase: auth);
    return Provider<AuthFormBloc>(
        create: (_) => bloc,
        dispose: (_, bloc) => bloc.dipose(),
        child: Consumer<AuthFormBloc>(
          builder: (_, value, __) => AuthForm(
            bloc: value,
          ),
        ));
  }

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> _opacityAnimation;
  Animation<double> _forgetPasswordAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _forgetPasswordAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Widget _buildCategoryAuthenText(
      {AuthFormModel model,
      String text,
      BuildContext context,
      AuthFormType current}) {
    Color color;
    color = model.authFormType == current
        ? CustomColor.yellow
        : CustomColor.black[2];
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
          onTap: () => widget.bloc.toggleForm(_animationController, current),
          child: CustomFont(
            text: text,
            color: color,
            context: context,
            fontSize: 20,
          )),
      SizedBox(
        height: 8,
      )
    ]);
  }

  Widget _buildAnimationHorizontalSize({AuthFormModel model, Size deviceSize}) {
    return AnimatedPositioned(
      child: Container(
          height: 4, width: deviceSize.width / 4.68, color: CustomColor.yellow),
      duration: Duration(milliseconds: 300),
      bottom: 0,
      left: model.authFormType == AuthFormType.signIn
          ? deviceSize.width / 8.7
          : deviceSize.width / 1.75,
    );
  }

  Widget _buildFormContainer({Size deviceSize, AuthFormModel model}) {
    final authFormType = model.authFormType;
    final _heightContainer = authFormType == AuthFormType.register
        ? deviceSize.height / 1.5 - deviceSize.height / 17.5
        : deviceSize.height / 1.5 - deviceSize.height / 7;
    final _maxHeightForgetPassword =
        authFormType == AuthFormType.register ? 0.0 : 20.0;
    final _minHeightForgetPassword =
        authFormType == AuthFormType.register ? 0.0 : 10.0;
    final textBtn = authFormType == AuthFormType.signIn ? 'Sign in' : 'Sign up';
    final _minHeightForgetPasswordContainer =
        authFormType == AuthFormType.register ? 60.0 : 0.0;
    final _maxHeightForgetPasswordContainer =
        authFormType == AuthFormType.register ? 120.0 : 0.0;

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 16,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      curve: Curves.easeIn,
      height: _heightContainer,
      width: deviceSize.width / 1.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: CustomColor.white,
          child: Container(
            width: deviceSize.width * 0.75,
            padding: EdgeInsets.all(16.0),
            child: Form(
              // key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: (deviceSize.height / 1.81 -
                              deviceSize.height / 17.5) /
                          7.65,
                    ),
                    CustomTextForm(
                      placeHolder: 'Email',
                      assetImage: 'assets/images/profile.png',
                      // validator: _validatorEmail,
                      // authData: _authData,
                      controller: null,
                      isSecure: false,
                      authDataType: 'email',
                      deviceSize: deviceSize,
                    ),
                    SizedBox(
                      height: (deviceSize.height / 1.81 -
                              deviceSize.height / 17.5) /
                          10.2,
                    ),
                    CustomTextForm(
                      placeHolder: 'Password',
                      assetImage: 'assets/images/lock.png',
                      // validator: _validatorPassword,
                      // authData: _authData,
                      // controller: _passwordController,
                      isSecure: true,
                      authDataType: 'password',
                      deviceSize: deviceSize,
                    ),
                    if (authFormType == AuthFormType.signIn)
                      SizedBox(
                        height: (deviceSize.height / 1.81 -
                                deviceSize.height / 17.5) /
                            20.4,
                      ),
                    AnimatedContainer(
                      constraints: BoxConstraints(
                          minHeight: _minHeightForgetPassword,
                          maxHeight: _maxHeightForgetPassword),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                        opacity: _forgetPasswordAnimation,
                        child: CustomFont(
                            context: context,
                            text: 'Forgot Password?',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.yellow),
                      ),
                    ),
                    if (authFormType == AuthFormType.register)
                      SizedBox(
                        height: (deviceSize.height / 1.81 -
                                deviceSize.height / 17.5) /
                            10.2,
                      ),
                    AnimatedContainer(
                      constraints: BoxConstraints(
                          minHeight: _minHeightForgetPasswordContainer,
                          maxHeight: _maxHeightForgetPasswordContainer),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: CustomTextForm(
                          placeHolder: 'Confirm password',
                          assetImage: 'assets/images/lock.png',
                          // validator: _validatorConfirmPassword,
                          // authData: _authData,
                          controller: null,
                          isSecure: true,
                          authDataType: 'password',
                          deviceSize: deviceSize,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (deviceSize.height / 1.81 -
                              deviceSize.height / 17.5) /
                          10.2,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        color: CustomColor.yellow,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HomePage(),
                                transitionDuration: Duration(milliseconds: 750),
                              ));
                            },
                            child: Text(
                              textBtn,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: deviceSize.height / 34),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return StreamBuilder<AuthFormModel>(
        stream: widget.bloc.modelStream,
        initialData: AuthFormModel(),
        builder: (context, snapshot) {
          final _model = snapshot.data;

          return Container(
            height: deviceSize.height / 1.5,
            width: deviceSize.width / 1.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(children: [
                  Container(
                    height: deviceSize.height / 17.5,
                    color: CustomColor.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryAuthenText(
                            context: context,
                            current: AuthFormType.signIn,
                            model: _model,
                            text: 'Sign in'),
                        _buildCategoryAuthenText(
                            context: context,
                            current: AuthFormType.register,
                            model: _model,
                            text: 'Sign up'),
                      ],
                    ),
                  ),
                  _buildAnimationHorizontalSize(
                      deviceSize: deviceSize, model: _model)
                ]),
                _buildFormContainer(deviceSize: deviceSize, model: _model)
              ],
            ),
          );
        });
  }
}
