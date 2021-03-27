import 'package:flutter/cupertino.dart';

class CustomSizedBox extends SizedBox {
  static final heightMockUp = 812;
  static final widthMockUp = 375;
  final height;
  final width;
  CustomSizedBox(
      {@required BuildContext context, this.height: 0, this.width: 0})
      : super(
            height:
                MediaQuery.of(context).size.height / (heightMockUp / height),
            width: MediaQuery.of(context).size.width / (widthMockUp / width));
}
