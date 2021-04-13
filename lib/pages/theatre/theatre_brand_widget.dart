import 'package:btix/common/custom_color.dart';
import 'package:btix/models/theatre_brand.dart';
import 'package:flutter/material.dart';

class TheatreBrandWidget extends StatelessWidget {
  final TheatreBrand brand;
  final Size deviceSize;
  TheatreBrandWidget({this.brand, this.deviceSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 8),
      width: deviceSize.width / 2.2,
      height: deviceSize.height / 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: Container(
        height: deviceSize.height / 20,
        width: deviceSize.height / 20,
        child: Center(
          child: Image.network(
            brand.logo.replaceAll('http', 'https'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
