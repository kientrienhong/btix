import 'package:btix/pages/home/home_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return HomeContainer.create(context);
  }
}
