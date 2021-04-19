import 'package:btix/common/custom_color.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String placeHolder;
  final String assetImage;
  final TextEditingController controller;
  final Size deviceSize;
  final Function validator;
  final bool isSecure;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  CustomTextForm({
    this.placeHolder,
    this.nextFocusNode,
    this.focusNode,
    this.assetImage,
    this.controller,
    this.deviceSize,
    this.validator,
    this.isSecure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: CustomColor.black[0], fontSize: deviceSize.height / 40),
      cursorColor: CustomColor.yellow,
      obscureText: isSecure,
      controller: controller,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        focusNode.unfocus();
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 18),
          labelText: placeHolder,
          labelStyle: TextStyle(color: CustomColor.black[2]),
          fillColor: CustomColor.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          focusedBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: CustomColor.black[3],
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Container(
              width: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      assetImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 2,
                    height: 24,
                    color: CustomColor.black[1],
                    child: null,
                  )
                ],
              ),
            ),
          )),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => validator(value),
      focusNode: focusNode,
    );
  }
}
