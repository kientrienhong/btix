import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;
  final Size deviceSize;
  final double width;
  CustomRaisedButton(
      {this.height,
      this.width,
      this.deviceSize,
      this.child,
      this.color,
      this.borderRadius: 2.0,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceSize.height / (812 / height),
      width: deviceSize.width / (375 / width),
      child: RaisedButton(
          onPressed: onPressed,
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          child: child),
    );
  }
}
