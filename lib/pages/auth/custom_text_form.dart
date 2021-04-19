import 'package:btix/common/custom_color.dart';
import 'package:btix/pages/auth/auth_form_model.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends TextFormField {
  final String placeHolder;
  final String assetImage;
  final Function validation;
  final TextEditingController controller;
  final Size deviceSize;
  final FocusNode focusNode;
  final bool isSecure;
  CustomTextForm(
      {this.placeHolder,
      this.validation,
      this.focusNode,
      this.assetImage,
      this.controller,
      this.deviceSize,
      this.isSecure})
      : super(
            style: TextStyle(
                color: CustomColor.black[0],
                fontSize: deviceSize.height / 40,
                fontWeight: FontWeight.bold),
            cursorColor: CustomColor.yellow,
            obscureText: isSecure,
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 18),
                labelText: placeHolder,
                labelStyle: TextStyle(
                    color: CustomColor.black[2], fontWeight: FontWeight.bold),
                fillColor: CustomColor.black[3],
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Container(
                    width: 48,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          assetImage,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: 2,
                          height: 24,
                          color: CustomColor.white,
                          child: null,
                        )
                      ],
                    ),
                  ),
                )),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validation(value));
}
