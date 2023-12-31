import 'package:flutter/material.dart';
import 'package:mitsubishi_app/service/api_service.dart';
import 'package:mitsubishi_app/model/device.dart';
import 'package:flutter_blufi/flutter_blufi.dart';

import '../screens/tabs.dart';
import '../widget/static_style.dart';

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
          builder: (context) => TabsScreen(),
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
          title: Text('新增設備'),
        ),

        body:content()
    );


  }

  Widget content(){
    var espBlufi = EspBlufi.instance.getMac();
    return Center(
      child: Column(
        children: [
          Text('請確認', style: TextStyle(fontSize: 24),),
          Text(' • 行動裝置是否連上Wi-Fi環境', style: TextStyle(fontSize: 24),),
          Text(' • 裝置燈是否正常', style: TextStyle(fontSize: 24),),
          SizedBox(height: 20,),
          Text('確認完請點擊', style: TextStyle(fontSize: 24),),
          Theam().next_step_Buttons('註冊設備', context, () {_connectdevice(espBlufi); }),
          SizedBox(height: 60,),
          Text('若30秒後，裝置燈依舊沒有正常亮起', style: TextStyle(fontSize: 24),),
          Text('請重新進行配對步驟', style: TextStyle(fontSize: 24),),
          SizedBox(height: 20,),
          Theam().next_step_Buttons('重新配對', context, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TabsScreen(),
              ),
            );
          }),
        ],
      ),
    );
  }
}