import 'package:btix/common/custom_color.dart';
import 'package:flutter/material.dart';
import '../constants/index.dart' as constants;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool isHome;

  CustomAppBar(this.isHome);

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
            if (isHome)
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 24, bottom: 8),
                child: Image.asset('assets/images/search.png'),
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(112);
}
