import 'package:flutter/material.dart';

import 'bluetooth_info.dart';
import 'bluetooth_info2.dart';
import 'bluetooth_screen.dart';

class PageSwitcher extends StatefulWidget {

  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  PageController _pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Container(
            color: Colors.blue,
            child: Center(
              child:BluetoothInfoPage() ,
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child:BluetoothInfoPage2() ,
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child:BluetoothScreen() ,
            ),
          ),


        ],
      ),
    );
  }
}