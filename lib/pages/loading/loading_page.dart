import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:flutter/material.dart';
import '../../constants/index.dart' as contants;

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: contants.LOGO_TAG,
              child: Container(
                  height: deviceSize.height / 11.5,
                  width: deviceSize.width / 4,
                  child: Image.asset(
                    'assets/images/logomobile.png',
                    fit: BoxFit.fill,
                  )),
            ),
            CustomSizedBox(
              context: context,
              height: 32,
            ),
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(CustomColor.yellow),
            )
          ],
        ),
      ),
    );
  }
}
