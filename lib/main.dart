import 'package:btix/pages/auth/auth_page.dart';
import 'package:btix/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: 'Roboto'),
        routes: {AuthPage.routeName: (ctx) => AuthPage()},
      ),
    );
  }
}
