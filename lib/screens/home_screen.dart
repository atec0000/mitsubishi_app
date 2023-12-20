import 'package:flutter/material.dart';
import 'package:mitsubishi_app/model/device.dart';
import 'package:mitsubishi_app/service/secure_storage_service.dart';

import '../auth_test/start_login.dart';
import '../home_info/device_card.dart';
import '../home_info/mqtt_connect.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SecureStorageService secureStorageService = SecureStorageService();

  List<Device> devices = [];
  bool isLoading = false;
  bool isConnecting = false;
  bool connectionSuccess = false;

  @override
  void initState() {
    super.initState();
    print('Getting devices');
  }



  void _logout() async {
    await secureStorageService.deleteAccessToken();
    await secureStorageService.deleteRefreshToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        // title: Image.asset("assets/logo.png"),
        title: Text('空調'),
        actions: [
          IconButton(onPressed: () => fetchDevices(), icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
      ),
      //body: buildListView(),
      body: MqttConnectionScreen(deviceMac: 'CCA614230008',),
    );
  }



}