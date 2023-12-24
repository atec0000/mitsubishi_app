import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

class SetAppinformation extends StatefulWidget {
  SetAppinformation({Key? key}) : super(key: key);
  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  _SetAppinformationState createState() => _SetAppinformationState();
}

class _SetAppinformationState extends State<SetAppinformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('系統資訊'),
        centerTitle: true,
      ),
      body: Platform.isAndroid
          ? showAndroidInfo()
          : Platform.isIOS
              ? showIOSInfo()
              : Container(),
    );
  }

  showAndroidInfo() {
    return FutureBuilder<AndroidDeviceInfo>(
      future: widget.deviceInfoPlugin.androidInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error getting Android device info: ${snapshot.error}');
          return Container();
        } else {
          final androidInfo = snapshot.data!;
          return Column(
            children: [
              settingWithImfo(
                title: 'App版本',
                info: androidInfo.version.release,
              ),
              settingWithImfo(
                title: '手機型號',
                info: androidInfo.model,
              ),
              settingWithImfo(
                title: '機型型號',
                info: androidInfo.manufacturer,
              ),
              settingWithImfo(
                title: '作業系統版本',
                info: '${androidInfo.version.sdkInt}',
              ),
              settingWithImfo(
                title: '瀏覽器核心版本',
                info: 'Not applicable for mobile devices',
              ),
              settingurl(
                title: '系統更新',
                textColor: Colors.black,
                onTapFunction: () {},
                context: context,
              ),
            ],
          );
        }
      },
    );
  }

  showIOSInfo() async {
    IosDeviceInfo iosInfo;
    try {
      iosInfo = await widget.deviceInfoPlugin.iosInfo;
    } catch (e) {
      print('Error getting iOS device info: $e');
      return Container(); // Handle the error gracefully
    }

    return Column(
      children: [
        settingWithImfo(
          title: 'App版本',
          info: iosInfo.systemVersion,
        ),
        settingWithImfo(
          title: '手機型號',
          info: iosInfo.model,
        ),
        settingWithImfo(
          title: '機型型號',
          info: iosInfo.utsname.machine,
        ),
        settingWithImfo(
          title: '作業系統版本',
          info: iosInfo.systemVersion,
        ),
        settingWithImfo(
          title: '瀏覽器核心版本',
          info: 'Not applicable for mobile devices',
        ),
        settingurl(
          title: '系統更新',
          textColor: Colors.black,
          onTapFunction: () {},
          context: context,
        ),
      ],
    );
  }
}
