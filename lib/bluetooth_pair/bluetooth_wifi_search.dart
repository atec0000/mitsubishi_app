import 'package:flutter/material.dart';
import 'package:flutter_blufi/flutter_blufi.dart';
import 'package:mitsubishi_app/widget/static_style.dart';

import 'bluetooth_wifi_connect.dart';

class Bluetoothwifisearch extends StatefulWidget {
  const Bluetoothwifisearch({Key? key}) : super(key: key);

  @override
  _BluetoothwifisearchState createState() => _BluetoothwifisearchState();
}

class _BluetoothwifisearchState extends State<Bluetoothwifisearch> {
  List<WifiScanResult> wifiList = [];
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

    Future.delayed(const Duration(seconds: 5), () {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增設備'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: wifiList.length,
                itemBuilder: (context, index) {
                  final wifiResult = wifiList[index];
                  return ListTile(
                    title: Text(wifiResult.ssid), // WiFi 名稱
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Bluetoothwificonnect(wifiResult: wifiResult),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Theam().next_step_Buttons('重新搜尋', context, () {
              searchForWifi();
            })
          ],
        ),
      ),
    );
  }
}
