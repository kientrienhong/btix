import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:flutter/material.dart';

enum StatusTypeInput { VALID, INVALID, DISABLE }

class CustomOutLineInput extends StatefulWidget {
  final Size deviceSize;
  final String labelText;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  StatusTypeInput statusTypeInput;
  final bool isDisable;
  final bool isSecure;
  CustomOutLineInput(
      {this.statusTypeInput,
      this.controller,
      this.textInputType: TextInputType.text,
      this.isDisable,
      this.isSecure: false,
      this.nextNode,
      this.focusNode,
      this.deviceSize,
      this.labelText});

  @override
  _CustomOutLineInputState createState() => _CustomOutLineInputState();
}

class _CustomOutLineInputState extends State<CustomOutLineInput> {
  Color colorBorder;
  Color colorLabel;
  @override
  void initState() {
    super.initState();

    switch (widget.statusTypeInput) {
      case StatusTypeInput.VALID:
        {
          colorLabel = Colors.black;
          colorBorder = CustomColor.black[3];
          break;
        }

      case StatusTypeInput.DISABLE:
        {
          colorLabel = CustomColor.black[3];
          colorBorder = CustomColor.black[3];
          break;
        }

      default:
        {
          colorLabel = Colors.red;
          colorBorder = Colors.red;
        }
    }
    widget.focusNode.addListener(_onFocusChange);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void _onFocusChange() {
    if (widget.focusNode.hasFocus) {
      setStateIfMounted(() {
        colorBorder = CustomColor.yellow;
        colorLabel = CustomColor.yellow;
      });
    } else {
      if (widget.controller.text.isEmpty) {
        setStateIfMounted(() {
          colorBorder = Colors.red;
          colorLabel = Colors.red;
          widget.statusTypeInput = StatusTypeInput.INVALID;
        });

        return;
      }
      setStateIfMounted(() {
        colorBorder = CustomColor.black[3];
        colorLabel = Colors.black;
        widget.statusTypeInput = StatusTypeInput.VALID;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.statusTypeInput != StatusTypeInput.INVALID
          ? widget.deviceSize.height / 8
          : widget.deviceSize.height / 7,
      width: widget.deviceSize.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            Container(
                height: widget.deviceSize.height / 14,
                padding: const EdgeInsets.only(left: 16, top: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorBorder, width: 1)),
                child: Center(
                  child: TextFormField(
                    obscureText: widget.isSecure,
                    keyboardType: widget.textInputType,
                    style: TextStyle(color: colorLabel),
                    enabled: !widget.isDisable,
                    textInputAction: widget.nextNode != null
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onFieldSubmitted: (term) {
                      widget.focusNode.unfocus();
                      if (widget.nextNode != null)
                        FocusScope.of(context).requestFocus(widget.nextNode);
                    },
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    cursorColor: CustomColor.yellow,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                )),
            Positioned(
              top: -widget.deviceSize.height / 50,
              left: 16,
              child: Container(
                color: CustomColor.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: CustomFont(
                  text: widget.labelText,
                  color: colorLabel,
                  context: context,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
        if (widget.statusTypeInput == StatusTypeInput.INVALID)
          CustomSizedBox(
            context: context,
            height: 8,
          ),
        if (widget.statusTypeInput == StatusTypeInput.INVALID)
          CustomFont(
            text: '* Required',
            color: Colors.red,
            context: context,
            textAlign: TextAlign.start,
            fontSize: 14,
          ),
        widget.statusTypeInput == StatusTypeInput.INVALID
            ? CustomSizedBox(
                context: context,
                height: 8,
              )
            : CustomSizedBox(
                context: context,
                height: 32,
              ),
      ]),
    );
  }
}
