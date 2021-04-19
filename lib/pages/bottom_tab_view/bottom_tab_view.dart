import 'package:btix/common/custom_app_bar.dart';
import 'package:btix/common/custom_bottom_navigation.dart';
import 'package:btix/pages/historyBooking/history_booking_page.dart';
import 'package:btix/pages/home/home_page.dart';
import 'package:btix/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class BottomTabView extends StatefulWidget {
  @override
  _BottomTabViewState createState() => _BottomTabViewState();
}

class _BottomTabViewState extends State<BottomTabView> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  void _tapTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      drawerScrimColor: Color.fromARGB(51, 51, 51, 5),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          CustomAppBar(true),
          Expanded(
            child: IndexedStack(
              index: _index,
              children: [HomePage(), HistoryBookingPage(), ProfilePage()],
            ),
          ),
          CustomBottomNavigation(
            deviceSize: deviceSize,
            index: _index,
            tapTab: _tapTab,
          ),
        ],
      ),
    );
  }
}
