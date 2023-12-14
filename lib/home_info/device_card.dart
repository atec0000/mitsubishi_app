import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bluetooth_pair/bluetooth_screen.dart';
import '../bluetooth_pair/pageswitch_blufi.dart';
import '../model/ac_status_ca51.dart';
import '../model/device.dart';
import '../screens/aircontrol_screen.dart';
import '../service/api_service.dart';
import '../service/command_parser_ca51.dart';
import '../service/tcp_service.dart';
import '../widget/static_style.dart';
import '../service/receive_data.dart';

final ApiService _apiService = ApiService();
final TcpService _tcpService = TcpService();

List<Device> devices = [];
AcStatusCa51 _acStatus = AcStatusCa51.off();

Future<void> fetchDevices() async {
  try {
    final List<Device> deviceList = await _apiService.getDevices();
    devices = deviceList;
  } catch (e) {
    // Handle errors
    print('Error fetching devices: $e');
  }
}

Widget buildCard(BuildContext context, Device device, AcStatusCa51 acStatus) {
  double cardSize = MediaQuery.of(context).size.width * 0.5;
  return InkWell(
    borderRadius: BorderRadius.circular(25.0),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AircontrolScreen(
            deviceMac: device.mac,
          ),
        ),
      );
    },
    child: Container(
      height: cardSize,
      width: cardSize,
      child: Card(
        elevation: 15,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(25.0),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(197, 0, 39, 73),
                Color.fromARGB(197, 0, 108, 253),
              ],
            ),
          ),
          child: buildCardContent(acStatus, device),
        ),
      ),
    ),
  );
}

Widget buildCardContent(AcStatusCa51 acStatus, Device device) {
  return Container(
    height: 200,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: getAcModeText(acStatus.mode),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0, top: 8.0),
              child: SwitchWidget(
                value: _acStatus.power,
                onChanged: (bool newvalue) {
                  if (newvalue != null) {
                    if (newvalue) {
                      _tcpService.sendCommand(get_TaiSEIA_other('80', 1, '01'));
                    } else {
                      _tcpService.sendCommand(get_TaiSEIA_other('80', 1, '00'));
                    }
                  }
                },
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),  // Added bottom padding
            child: Text(
              "${temperature.toInt()}°C ",
              style: TextStyle(fontSize: 45, color: Colors.lightBlue),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 16.0),  // Added bottom padding
            child: Text(
              "MHCAD_${device.mac.substring(device.mac.length - 4)}",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildListView() {
  return FutureBuilder(
    future: fetchDevices(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      } else {
        return ListView.builder(
          itemCount: (devices.length / 2).ceil() + (devices.length.isEven ? 1 : 0),
          itemBuilder: (context, rowIndex) {
            var startIndex = rowIndex * 2;
            var endIndex = startIndex + 2;
            endIndex = endIndex.clamp(0, devices.length);

            var cards = devices.sublist(startIndex, endIndex).map((device) {
              return buildCard(context, device, _acStatus);
            }).toList();
            // 在最後一行加入空白卡片中間有按鈕
            if (rowIndex == (devices.length / 2).floor()) {
              // 判斷是否有單獨格
              if (devices.length.isOdd) {
                // 在最後一行的下一格加入空白卡片中間有按鈕
                cards.add(
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: buildEmptyCardWithButton(
                        context,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  PageSwitcher(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }


              if (devices.length % 2 == 0) {
                cards.add(
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: buildEmptyCardWithButton(
                        context,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageSwitcher(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              if (devices.isEmpty) {
                final emptyCardWithButton = buildEmptyCardWithButton(
                  context,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageSwitcher(),
                      ),
                    );
                  },
                );

                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '請點擊這裡的',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 8),
                      emptyCardWithButton,
                      SizedBox(width: 8),
                      Text(
                        '開始新增設備',
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
            }

            return Row(
              children: cards,
            );
          },
        );
      }
    },
  );
}

Widget getAcModeText(AirConditionerMode mode) {
  if (_acStatus.power == false) {
    return SizedBox();
  }

  switch (mode) {
    case AirConditionerMode.auto:
      return Icon(Icons.hdr_auto);
    case AirConditionerMode.cool:
      return Icon(Icons.ac_unit);
    case AirConditionerMode.heat:
      return Icon(Icons.sunny);
    case AirConditionerMode.dry:
      return Icon(Icons.water_drop);
    case AirConditionerMode.fan:
      return Icon(Icons.wind_power);
  }
}

Widget buildEmptyCardWithButton(BuildContext context, ButtonCallback onPressed) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, right: 8.0),
    child: Material(
      borderRadius: BorderRadius.circular(50.0),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: onPressed,
        child: Container(
          width: 90, // Adjust the width as needed
          height: 90, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0), // Make it circular
            color: Colors.grey, // Transparent background
          ),
          alignment: Alignment.center, // Center the content
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}