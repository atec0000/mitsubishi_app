import 'package:flutter/material.dart';

import 'bluetooth_info.dart';
import 'bluetooth_info2.dart';
import 'bluetooth_screen.dart';

class PageSwitcher extends StatefulWidget {
  const PageSwitcher({super.key});

  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Container(
            color: Colors.blue,
            child: const Center(
              child: BluetoothInfoPage(),
            ),
          ),
          Container(
            color: Colors.blue,
            child: const Center(
              child: BluetoothInfoPage2(),
            ),
          ),
          Container(
            color: Colors.blue,
            child: const Center(
              child: BluetoothScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
