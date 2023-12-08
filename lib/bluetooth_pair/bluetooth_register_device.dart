import 'package:flutter/material.dart';
import 'package:mitsubishi_app/service/api_service.dart';
import 'package:mitsubishi_app/model/device.dart';
import 'package:flutter_blufi/flutter_blufi.dart';

import '../screens/home_screen.dart';

class Bluetoothselectdevice extends StatefulWidget {
  Bluetoothselectdevice({Key? key}) : super(key: key);

  final ApiService apiService = ApiService();


  @override
  _BluetoothselectdeviceState createState() => _BluetoothselectdeviceState();

}

class  _BluetoothselectdeviceState extends State<Bluetoothselectdevice> {

  final ApiService _apiService = ApiService();
  List<Device> devices = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print('Getting devices');
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final deviceList = await _apiService.getDevices();
      setState(() {
        devices = deviceList;
        isLoading = false;
      });
    } catch (e) {
      // Handle errors
      print('Error: $e');
      setState(() {
        isLoading = false; // Set loading state to false on error
      });
      // You can show an error message to the user if needed
    }
  }

  void _connectdevice(String mac) async {
    try {
      //await widget.apiService.StartSock();
      await widget.apiService.addDevice(mac);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (error) {
      print('Error connect device: $error');
      // 可以在这里更新UI或执行其他操作以显示错误消息
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Register device'
          ),
        ),
        body:Center(
          child: ElevatedButton(
            onPressed: (){
              var espBlufi = EspBlufi.instance.getMac();
              _connectdevice(espBlufi);
              print("Blue mac: $espBlufi");
            },
            child: Text('Register Device'),
          ),
        )
    );


  }
}