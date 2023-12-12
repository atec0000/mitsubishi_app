
import 'package:flutter/material.dart';
import '../widget/static_style.dart';
import 'package:open_settings/open_settings.dart';

import 'bluetooth_screen.dart';




class BluetoothInfoPage2 extends StatefulWidget {
  BluetoothInfoPage2 ({Key? key}) : super(key: key);



  @override
  _BluetoothInfoPage2State createState() => _BluetoothInfoPage2State();
}



class  _BluetoothInfoPage2State extends State<BluetoothInfoPage2> {

  @override
  void initState() {
    super.initState();
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
          Text('1.控制盒在2.4Ghz的Wi-Fi環境方可運作', style: TextStyle(fontSize: 24),textAlign: TextAlign.start,),
          SizedBox(height: 30),
          Image(
            image: NetworkImage('https://via.placeholder.com/350'),
            width: 350,
            height: 350,
          ),
          SizedBox(height: 30),
          Text('2.請確認行動裝置已開啟以下功能', style: TextStyle(fontSize: 24),textAlign: TextAlign.start,),
          Text(' • 行動數據', style: TextStyle(fontSize: 24),),
          Text(' • 藍芽功能', style: TextStyle(fontSize: 24)),
          Text(' • Wi-Fi連接', style: TextStyle(fontSize: 24)),
          Text(' • 允許取用位置訊息/定位權限', style: TextStyle(fontSize: 24)),
          Theam().next_step_Buttons('前往設定', context, () { openWifiSettings(); }),
          Theam().next_step_Buttons('下一步', context, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BluetoothScreen(),
              ),
            );
            }),
        ],
      ),
    );
  }
  void openWifiSettings() {
    OpenSettings.openWIFISetting();
  }


}