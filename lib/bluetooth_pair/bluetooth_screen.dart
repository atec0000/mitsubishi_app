import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blufi/flutter_blufi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mitsubishi_app/bluetooth_pair/bluetooth_connect.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // 导入modal_progress_hud_nsn




class BluetoothScreen extends StatefulWidget {
  BluetoothScreen ({Key? key}) : super(key: key);



  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}



class  _BluetoothScreenState extends State<BluetoothScreen> {
  List<ScanResult> deviceList = [];
  bool scanning = false;
  int connectionOrder = 1;

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
  Future<void> scanForDevices() async {
    setState(() {
      scanning = true;
    });

    final result = await EspBlufi.instance.scanForDevices('i-Ctrl');

    setState(() {
      scanning = false;
      deviceList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Scan Results'),
      ),

      body: ModalProgressHUD(
        inAsyncCall: scanning,
        child: ListView.builder(
          itemCount: deviceList.length,
          itemBuilder: (context, index) {
            final scanResult = deviceList[index];
            final serviceUuids = scanResult.advertisementData.serviceUuids;
            final servicename = scanResult.device.name.toString();
            final deviceID = scanResult.device.id.toString();
            final connectionOrder = index + 1;
            return InkWell(
              onTap: () async {
                if (!EspBlufi.instance.isConnectedToDevice(scanResult.device)) {
                  try {
                    await EspBlufi.instance.connectDevice(scanResult.device);
                    bool isConnected = await EspBlufi.instance.isConnectedToDevice(scanResult.device);
                    if (isConnected) {
                      await Future.delayed(const Duration(milliseconds: 300));

                      if (!Platform.isIOS) {
                        await EspBlufi.instance.setMtu(scanResult.device, 512);
                      }

                      await Future.delayed(const Duration(milliseconds: 200));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BluetoothconnectScreen(),
                        ),
                      );
                    } else {
                      print('Failed to connect to the device.');
                    }
                  } catch (e) {
                    print('Error connecting to device: $e');
                  }
                }
              },
              child: ListTile(
                title: Text('ID: $deviceID (Order: $connectionOrder)'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: serviceUuids.map((uuid) {
                    return Text('UUID: $uuid');
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          scanForDevices();
        },
        child: Icon(Icons.search),
      ),
    );
  }
}