import 'package:btix/common/custom_font.dart';
import 'package:flutter/material.dart';
import '../constants/index.dart' as constants;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool isHome;
  String name;
  CustomAppBar({this.isHome, this.name: ''});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 100),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 112,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 24, bottom: 8),
              child: isHome
                  ? Hero(
                      tag: constants.LOGO_TAG,
                      child: Image.asset(
                        'assets/images/logomobile.png',
                        height: 40,
                        width: 96,
                        fit: BoxFit.cover,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset('assets/images/backbutton.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 24, bottom: 8),
              child: CustomFont(
                text: name,
                color: Colors.black,
                context: context,
                fontSize: 14,
              ),
            ),
            if (isHome)
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 24, bottom: 8),
                child: Image.asset('assets/images/search.png'),
              ),
            if (!isHome)
              Container(
                width: 24,
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(112);
}
