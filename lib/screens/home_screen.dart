import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mitsubishi_app/service/secure_storage_service.dart';

import '../auth_test/start_login.dart';
import '../home_info/device/controller.dart';
import '../home_info/device/view.dart';
import '../service/mqtt_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SecureStorageService secureStorageService = SecureStorageService();
  final DeviceController deviceController = Get.put(DeviceController());

  @override
  void initState() {
    super.initState();
    print('Getting devices');
    connectToMqttServer();
  }

  void _logout() async {
    await secureStorageService.deleteAccessToken();
    await secureStorageService.deleteRefreshToken();
    Get.offAll(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('空調'),
        actions: [
          IconButton(
            onPressed: () => deviceController.fetchDevices(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Device_card(),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // 使用 Get.to 显示 FamilyView 页面
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => Addfamily(),
      //         ),
      //       );
      //     },
      //     child: Text('Add device to family.'),
      //   ),
      // ),
    );
  }

  Widget informaction() {
    return Column(
      children: [
        Device_card(),
        // buildListView(),
      ],
    );
  }
}
