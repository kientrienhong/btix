import 'package:btix/common/custom_font.dart';
import 'package:btix/models/theatre.dart';
import 'package:flutter/material.dart';

class TheatreWidget extends StatelessWidget {
  final Theatre theatre;
  final Size deviceSize;
  TheatreWidget({this.theatre, this.deviceSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: deviceSize.height / 7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 16,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: deviceSize.width / 1.5,
                  child: CustomFont(
                    textOverflow: null,
                    text: theatre.name,
                    color: Colors.black,
                    fontSize: 20,
                    context: context,
                  ),
                ),
                Image.asset('assets/images/arrowright.png')
              ],
            ),
          ),
        ));
  }
}
// CustomFont(
//                   textOverflow: null,
//                   text: theatre.name,
//                   color: Colors.black,
//                   fontSize: 20,
//                   context: context,
//                 ),
// Image.asset('assets/images/arrowright.png')
