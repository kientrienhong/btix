import 'package:flutter/cupertino.dart';

class CustomFont extends Text {
  static final heightMockUp = 812;
  static final widthMockUp = 375;
  CustomFont(
      {@required String text,
      Color color,
      BuildContext context,
      int fontSize,
      TextOverflow textOverflow: TextOverflow.ellipsis,
      FontWeight fontWeight: FontWeight.normal})
      : super(text,
            overflow: textOverflow,
            style: TextStyle(
                fontWeight: fontWeight,
                color: color,
                fontFamily: 'Roboto',
                fontSize: MediaQuery.of(context).size.width /
                    (widthMockUp / fontSize)));
}
