import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:flutter/material.dart';

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
