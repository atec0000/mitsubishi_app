import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../setting/setting_screen.dart';
import 'automation_page.dart';
import 'home_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  late Widget activePage;

  @override
  void initState() {
    super.initState();
    // 初始化時將主頁設置為HomeScreen
    activePage = const HomeScreen(); // 在這裡初始化主頁
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      // 根據所選索引設置activePage和activePageTitle
      switch (index) {
        case 0:
          activePage = const HomeScreen(); // 選擇主頁
          break;
        case 1:
          activePage = const AutomationPage();
          break;
        case 2:
          activePage = const SetScreen();
          break;
        default:
        // 如果有更多選項，可以在這裡添加其他選項的處理
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.white.withOpacity(0.2),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.microchip), label: 'Automation'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.gear), label: 'Setting'),
        ],
      ),
    );
  }
}
