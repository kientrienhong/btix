import 'package:btix/apis/api.dart';
import 'package:btix/common/custom_app_bar.dart';
import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_outline_input.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  bool _isLoading;
  FocusNode _currentPasswordNode = FocusNode();
  FocusNode _newPasswordNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();
  StringBuffer errorMsg = StringBuffer();

  String get currentPassword => _currentPasswordController.text;
  String get newPassword => _newPasswordController.text;
  String get confirmPasword => _confirmController.text;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _currentPasswordNode.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmController.dispose();
    _newPasswordNode.dispose();
    _confirmPasswordNode.dispose();
  }

  void changePassword() async {
    errorMsg.clear();
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPasword.isEmpty) {
      Toast.show("Please fill all input", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      return;
    }

    if (newPassword != confirmPasword) {
      setState(() {
        errorMsg.write('Password not match');
      });
      return;
    }

    try {
      AuthBase auth = Provider.of<AuthBase>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      final response = await Api.getAccountInfo(auth.user.username);

      if (currentPassword != response['matKhau']) {
        setState(() {
          errorMsg.write('Incorrect current password!');
        });
        return;
      }

      await Api.updateAccountInfo(auth.user, password: confirmPasword);
      Toast.show("Change successful!", context,
          backgroundColor: Colors.green,
          textColor: CustomColor.white,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        appBar: CustomAppBar(
          isHome: false,
          name: 'Change Password',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                CustomSizedBox(
                  context: context,
                  height: 32,
                ),
                CustomOutLineInput(
                  deviceSize: deviceSize,
                  labelText: 'Current Password',
                  focusNode: _currentPasswordNode,
                  controller: _currentPasswordController,
                  nextNode: _newPasswordNode,
                  isDisable: false,
                  isSecure: true,
                  statusTypeInput: StatusTypeInput.VALID,
                ),
                CustomOutLineInput(
                  deviceSize: deviceSize,
                  labelText: 'New password',
                  controller: _newPasswordController,
                  focusNode: _newPasswordNode,
                  nextNode: _confirmPasswordNode,
                  statusTypeInput: StatusTypeInput.VALID,
                  isDisable: false,
                  isSecure: true,
                ),
                CustomOutLineInput(
                  deviceSize: deviceSize,
                  labelText: 'Confirm new password',
                  controller: _confirmController,
                  focusNode: _confirmPasswordNode,
                  isDisable: false,
                  isSecure: true,
                  statusTypeInput: StatusTypeInput.VALID,
                ),
                if (errorMsg.toString().isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CustomFont(
                      text: errorMsg.toString(),
                      color: Colors.red,
                      context: context,
                      fontSize: 14,
                    ),
                  ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: deviceSize.width / 2.1,
                    height: deviceSize.height / 14,
                    color: CustomColor.yellow,
                    child: Center(
                      child: InkWell(
                        onTap: () => changePassword(),
                        child: _isLoading == true
                            ? CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    CustomColor.white))
                            : Text(
                                'Change',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: deviceSize.height / 34),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
