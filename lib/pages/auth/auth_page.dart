import 'package:btix/common/custom_sized_box.dart';

import '../../common/custom_color.dart';
import './auth_form.dart';
import 'package:flutter/material.dart';
import '../../constants/index.dart' as constants;

class AuthPage extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: CustomColor.white),
          ),
          SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomSizedBox(
                    context: context,
                    height: 98,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Hero(
                          tag: constants.LOGO_TAG,
                          child: Container(
                            height: deviceSize.height / 10,
                            width: deviceSize.width / 4.16,
                            child: Image.asset(
                              'assets/images/logomobile.png',
                            ),
                          ),
                        ),
                      ]),
                  CustomSizedBox(
                    context: context,
                    height: 50,
                  ),
                  AuthForm.create(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
