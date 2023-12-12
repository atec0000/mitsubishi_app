
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widget/static_style.dart';
import 'bluetooth_info2.dart'; // 导入modal_progress_hud_nsn




class BluetoothInfoPage extends StatefulWidget {
  BluetoothInfoPage ({Key? key}) : super(key: key);



  @override
  _BluetoothInfoPageState createState() => _BluetoothInfoPageState();
}



class  _BluetoothInfoPageState extends State<BluetoothInfoPage> {

  @override
  void initState() {
    super.initState();
    requestBluetoothPermissions(); // Request Bluetooth permissions when the screen initializes.
  }

  Future<bool> requestBluetoothPermissions() async {
    bool permOne = await Permission.bluetoothScan.request().isGranted;
    bool permTwo = await Permission.bluetoothAdvertise.request().isGranted;
    bool permThree = await Permission.bluetoothConnect.request().isGranted;

    return permOne && permTwo && permThree ? true : false;
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('請按下設備配對鍵進入配對模式', style: TextStyle(fontSize: 24),textAlign: TextAlign.start,),
          SizedBox(height: 50),
          Image(
            image: NetworkImage('https://via.placeholder.com/350'),
            width: 350,
            height: 350,
          ),
          SizedBox(height: 100),
          Theam().next_step_Buttons('下一步', context, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BluetoothInfoPage2(),
              ),
            );
          }),
        ],
      ),
    );
  }
}