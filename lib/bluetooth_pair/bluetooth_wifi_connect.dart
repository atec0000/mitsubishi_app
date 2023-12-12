import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blufi/flutter_blufi.dart';

import '../widget/static_style.dart';
import 'bluetooth_register_device.dart';


class Bluetoothwificonnect extends StatefulWidget {
  late final WifiScanResult wifiResult;

  Bluetoothwificonnect({
    required this.wifiResult,
  });




  @override
  _BluetoothwificonnectState createState() => _BluetoothwificonnectState();
}



class  _BluetoothwificonnectState extends State<Bluetoothwificonnect> {
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _connecting = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkWifiConnectionStatus() async {
    final completer = Completer<bool>();
    var checkNr = 0;
    bool finished = false;
    EspBlufi.instance.setReadListener((data) async {
      if (data.isNotEmpty) {
        if (data.length > 5 && data[0] == 0x3d && data[5] == 0x00) {
          finished = true;
          if (!completer.isCompleted) {
            completer.complete(true);
          }
        }
        checkNr++;
        if (checkNr > 5) {
          finished = true;
          if (!completer.isCompleted) {
            completer.complete(false);
          }
        }
        if (!finished) {
          await EspBlufi.instance.queryDeviceStatus();
          await Future.delayed(const Duration(seconds: 3));
        }
      }
    });
    await EspBlufi.instance.queryDeviceStatus();

    return completer.future;
  }

  Future<void> _connectToDevice() async {
    setState(() {
      _connecting = true;
    });

    try {
      EspBlufi.instance.sendRouterDataAndConnectSta(widget.wifiResult.ssid, _passwordController.text);
      // 连接成功后检查连接状态
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bluetoothselectdevice(),
        ),
      );
      await checkWifiConnectionStatus();

    } catch (e) {
      print('連接失敗: $e');
      // 在这里添加逻辑以重新连接或显示错误信息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('連接失敗，請檢查密碼重新嘗試'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _connecting = false;
      });
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

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Widget content(){
    return SingleChildScrollView(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('正在將設備連接至Wi-Fi', style: TextStyle(fontSize: 24),textAlign: TextAlign.start,),
              Image(
                image: NetworkImage('https://via.placeholder.com/350'),
                width: 350,
                height: 350,
              ),
              SizedBox(height: 50),
              Text('Wi-Fi名稱 :', style: TextStyle(fontSize: 24)),
              Text('${widget.wifiResult.ssid}', style: TextStyle(fontSize: 24)),
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: '輸入密碼',
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black), // 設置標籤文字的顏色
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)), // 設置提示文字的顏色
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              Theam().next_step_Buttons('下一步', context, () {
                _connectToDevice();
              }),
            ],
          ),
        ),
    );

  }
}