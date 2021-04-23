import 'package:btix/apis/api.dart';
import 'package:btix/common/custom_app_bar.dart';
import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_outline_input.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/models/user.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UpdateInfoPage extends StatefulWidget {
  @override
  _UpdateInfoPageState createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  bool isLoading = false;
  FocusNode _emailNode = FocusNode();
  FocusNode _nameNode = FocusNode();
  FocusNode _usernameNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String get _email => _emailController.text;
  String get _name => _nameController.text;
  String get _username => _usernameController.text;
  String get _phone => _phoneController.text;

  StatusTypeInput phoneStatus = StatusTypeInput.VALID;
  StatusTypeInput nameStatus = StatusTypeInput.VALID;
  @override
  void dispose() {
    super.dispose();
    _emailNode.dispose();
    _emailController.dispose();
    _nameNode.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _usernameNode.dispose();
    _phoneNode.dispose();
    _phoneController.dispose();
  }

  void handleUpdate() async {
    try {
      if (_phone.isEmpty || _name.isEmpty) {
        Toast.show("Please fill all input", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        return;
      }

      setState(() {
        isLoading = true;
      });
      AuthBase auth = Provider.of<AuthBase>(context, listen: false);
      User user = auth.user.copyWith(
          email: _email, name: _name, phone: _phone, username: _username);

      await Api.updateAccountInfo(user);

      auth.updateUser(user);
      Toast.show("Update successful!", context,
          backgroundColor: Colors.green,
          textColor: CustomColor.white,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    User user = auth.user;
    _emailController.text = user.email;
    _nameController.text = user.name;
    _usernameController.text = user.username;
    _phoneController.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        appBar: CustomAppBar(
          isHome: false,
          name: 'Account information',
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
                  labelText: 'Email',
                  focusNode: _emailNode,
                  controller: _emailController,
                  nextNode: _usernameNode,
                  isDisable: true,
                  statusTypeInput: StatusTypeInput.DISABLE,
                ),
                CustomOutLineInput(
                  deviceSize: deviceSize,
                  labelText: 'Username',
                  controller: _usernameController,
                  focusNode: _usernameNode,
                  nextNode: _nameNode,
                  statusTypeInput: StatusTypeInput.DISABLE,
                  isDisable: true,
                ),
                CustomOutLineInput(
                  deviceSize: deviceSize,
                  labelText: 'Name',
                  controller: _nameController,
                  focusNode: _nameNode,
                  nextNode: _phoneNode,
                  isDisable: false,
                  statusTypeInput: nameStatus,
                ),
                CustomOutLineInput(
                  deviceSize: deviceSize,
                  labelText: 'Phone',
                  isDisable: false,
                  controller: _phoneController,
                  focusNode: _phoneNode,
                  textInputType: TextInputType.number,
                  statusTypeInput: phoneStatus,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: deviceSize.width / 2.1,
                    height: deviceSize.height / 14,
                    color: CustomColor.yellow,
                    child: Center(
                      child: InkWell(
                        onTap: () => handleUpdate(),
                        child: isLoading == true
                            ? CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    CustomColor.white))
                            : Text(
                                'Update',
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
