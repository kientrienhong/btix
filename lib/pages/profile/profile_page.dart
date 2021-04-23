import 'package:btix/common/custom_color.dart';
import 'package:btix/common/custom_font.dart';
import 'package:btix/common/custom_sized_box.dart';
import 'package:btix/pages/auth/auth_page.dart';
import 'package:btix/pages/change_password.dart/change_password_page.dart';
import 'package:btix/pages/update_info/update_info_page.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  Widget _buildMenu({String name, String image, BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image),
        CustomSizedBox(
          context: context,
          height: 12,
        ),
        CustomFont(
          text: name,
          context: context,
          color: Colors.black,
          fontSize: 12,
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: CustomFont(
              text: 'Log out',
              color: Colors.black,
              context: context,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => (AuthPage()),
                      ),
                      (route) => false,
                    );
                  },
                  child: CustomFont(
                    text: 'Log out',
                    color: Colors.red,
                    context: context,
                    fontSize: 12,
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomFont(
                    text: 'Cancel',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 12,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSizedBox(
              context: context,
              height: 32,
            ),
            CustomFont(
              text: auth.user.name,
              color: Colors.black,
              context: context,
              fontSize: 24,
            ),
            CustomSizedBox(
              context: context,
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => (UpdateInfoPage()),
                      ),
                    );
                  },
                  child: _buildMenu(
                      context: context,
                      image: './assets/images/document.png',
                      name: 'Change infomation'),
                ),
                _buildMenu(
                    context: context,
                    image: './assets/images/ticket.png',
                    name: 'My ticket')
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            (ChangePasswordPage()),
                      ),
                    );
                  },
                  child: _buildMenu(
                      context: context,
                      image: './assets/images/lockblack.png',
                      name: 'Change password'),
                ),
                GestureDetector(
                  onTap: () => _showDialog(context),
                  child: _buildMenu(
                      context: context,
                      image: './assets/images/logout.png',
                      name: 'Log out'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
