import 'dart:async';

import 'package:mitsubishi_app/bluetooth_pair/bluetooth_register_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blufi/flutter_blufi.dart';


class BluetoothconnectScreen extends StatefulWidget {
  BluetoothconnectScreen ({Key? key}) : super(key: key);




  @override
  _BluetoothconnectScreenState createState() => _BluetoothconnectScreenState();
}



class  _BluetoothconnectScreenState extends State<BluetoothconnectScreen> {
  List<WifiScanResult> wifiList = [];
  String password = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    searchForWifi();
  }



  Future<void> searchForWifi() async {
    wifiList.clear();
    setState(() {
      isLoading = true;
    });

    print(wifiList);

    bool stopSearching = false;

    Future.delayed(Duration(seconds: 5), () {
      stopSearching = true;
      setState(() {
        isLoading = false;
      });
    });

    //尋找附近的WiFi
    EspBlufi.instance.queryWifiList((List<WifiScanResult> wifiScanResults) {
      //這裡有找到wifi
      setState(() {
        wifiList = wifiScanResults;
        if (!stopSearching) {
          isLoading = false;
        }
      });
      print(wifiList);
    }).catchError((error) {
      print('Error querying WiFi list: $error');
      setState(() {
        isLoading = false;
      });
    });
  }

  void _inputpassword (WifiScanResult wifiResult) async{
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(wifiResult.ssid),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  password = value;
                  print(password);
                  EspBlufi.instance.sendRouterDataAndConnectSta(wifiResult.ssid, password);
                  checkWifiConnectionStatus().then((connected) {
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 取消按钮
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Bluetoothselectdevice(),
                  ),
                );
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
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






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search WiFi Networks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: searchForWifi,
              child: Text('Search WiFi'),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: wifiList.length,
                itemBuilder: (context, index) {
                  final wifiResult = wifiList[index];
                  return ListTile(
                    title: Text(wifiResult.ssid), // WiFi名稱
                    onTap: () {
                      _inputpassword(wifiResult);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}