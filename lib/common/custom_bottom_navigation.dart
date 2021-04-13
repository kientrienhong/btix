import 'package:btix/common/custom_color.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final Size deviceSize;
  CustomBottomNavigation({this.deviceSize});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 16,
            left: deviceSize.width / 7,
            right: deviceSize.width / 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 16,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                selectedItemColor: CustomColor.yellow,
                backgroundColor: CustomColor.white,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/home.png'),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/document.png'),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/profile.png'),
                      ),
                      label: ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
