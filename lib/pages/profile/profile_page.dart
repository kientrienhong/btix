import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomFont(
            text: auth.user.name,
            color: Colors.black,
            context: context,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
