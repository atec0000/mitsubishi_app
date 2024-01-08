import 'dart:async';
import 'dart:convert';

import 'package:mitsubishi_app/model/ac_status_ca51.dart';
import 'package:mitsubishi_app/service/command_parser_ca51.dart';
import 'package:mitsubishi_app/widget/static_style.dart';
import 'package:flutter/material.dart';


import 'package:mitsubishi_app/service/tcp_service.dart';

import '../../model/temp_hum.dart';
import '../service/mqtt_service.dart';



class AircontrolScreen extends StatefulWidget {
  final String deviceMac;

  AircontrolScreen({required this.deviceMac});

  @override
  _AircontrolScreenState createState() => _AircontrolScreenState();
}

class _AircontrolScreenState extends State<AircontrolScreen> {
  final TcpService _tcpService = TcpService();
  bool isConnecting = false;
  bool connectionSuccess = false;
  AcStatusCa51 _acStatus = AcStatusCa51.off();


  int _AirtemperatureValue = 16;
  late double _newAirtemperatureValue = 16.0;

  Timer? _debounce;
  bool _isLoading = false;
  bool power = false;



  @override
  void initState() {
    super.initState();
    connectToDevice();
  }

  @override
  void dispose() {
    super.dispose();
    // super.dispose();
  }


  void connectToDevice() async {
    setState(() {
      isConnecting = true; // Set connecting state to true
    });

    // Attempt to connect to the device using TcpService
    // final connected = await _tcpService.connectToServer(widget.deviceMac);
    final connected = await connectToMqttServer();

    setState(() {
      isConnecting = false; // Set connecting state to false after the attempt
      connectionSuccess = connected;
    });
    if(connected) {
      subscribeToTopic(widget.deviceMac);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('臥室冷氣',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: isConnecting
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : connectionSuccess
          ? _buildConnectedUI()
          : _buildConnectionErrorUI(),
    );
  }

  Widget _buildConnectedUI() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: SwitchWidget(
                    value:power,
                    onChanged: (bool newvalue) {
                      if (newvalue != null) {
                        if (newvalue) {
                          // _tcpService.sendCommand(get_TaiSEIA_other('80', 1, '01'));
                          setState(() {
                            power = newvalue;
                            // _tcpService.sendCommand(air_poweron);
                            publishHexMessage(air_poweron,widget.deviceMac);
                          });


                        } else {
                          setState(() {
                            power = newvalue;
                            // _tcpService.sendCommand(get_TaiSEIA_other('80', 1, '00'));
                            // _tcpService.sendCommand(air_poweroff);
                            publishHexMessage(air_poweroff,widget.deviceMac);
                          });

                        }
                      }
                    },
                  ),
                ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20), // Adjust the top margin as needed
              child: CustomSlider(
                value: _newAirtemperatureValue,
                min: _acStatus.power ? 16.0 : 0,
                max: 30.0,
                onChanged: (newvalue) {
                  if (_acStatus.power) {
                    if (newvalue < 16.0) {
                      newvalue = 16.0;
                    }
                  }
                  setState(() {
                    _newAirtemperatureValue = newvalue;
                    _AirtemperatureValue = newvalue.toInt();
                  });
                  _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 75), () {
                    _tcpService.sendCommand(get_temperature(newvalue.toInt()));
                  });
                },
                powerOn: _acStatus.power,
                isLoading: _isLoading,
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2),
                        Text(
                          '23°C',
                          style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '室內溫度',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5), // Reduced width
                  Container(
                    height: 30,
                    width: 3,
                    color: Color.fromARGB(250, 59, 56, 56),
                  ),
                  SizedBox(width: 5), // Reduced width
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2),
                        Text(
                          '19°C',
                          style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '室外溫度',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Theam().buildCustomGradientRectangle(
              context,
              [
                Column(
                  children: [
                    Text(
                      '模       式',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildIconButton(Icons.ac_unit,(){_tcpService.sendCommand(get_TaiSEIA_other('81', 1, '00'));}, iconColor: Colors.white),
                        SizedBox(width: 35),
                        buildIconButton(Icons.wind_power,(){_tcpService.sendCommand(get_TaiSEIA_other('81', 1, '02'));}, iconColor: Colors.white),
                        SizedBox(width: 35),
                        buildIconButton(Icons.water_drop,(){_tcpService.sendCommand(get_TaiSEIA_other('81', 1, '01'));}, iconColor: Colors.white),
                        SizedBox(width: 35),
                        buildIconButton(Icons.sunny,(){_tcpService.sendCommand(get_TaiSEIA_other('81', 1, '04'));}, iconColor: Colors.white),
                        SizedBox(width: 35),
                        buildIconButton(Icons.hdr_auto,(){_tcpService.sendCommand(get_TaiSEIA_other('81', 1, '03'));}, iconColor: Colors.white),
                        // Add more widgets here if needed
                      ],
                    ),
                  ],
                )
              ],
              80,
              30,
            ),
            SizedBox(height: 3,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theam().buildCustomRectangle(context, "風   速", _acStatus.windSpeed, Icons.air,(){_tcpService.sendCommand(get_windspeed(5));}),
                // Theam().buildCustomRectangle(context, "上下風向", _acStatus.windDirectionud, Icons.arrow_upward,(){get_winddirection_updown(17);}),
                Theam().buildCustomRectangle(context, "上下風向", Text('上下風向'), Icons.arrow_upward,(){
                  _tcpService.sendCommand(air_updown);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _tcpService.sendCommand(air_updown);
                  });
                }),
                Theam().buildCustomRectangle(context, "左右風向", _acStatus.windDirectionlr, Icons.arrow_forward,(){_tcpService.sendCommand(get_winddirection_leftright(17));}),
                Theam().buildCustomRectangleSwitch(context, "定時開關1小時"),
                // 添加其他部件
                // ...

              ],
            )



            // 添加其他部件
            // ...
          ],
        ),
      ),
    );
  }

  Widget getAcModeText(AirConditionerMode mode) {
    switch (mode) {
      case AirConditionerMode.auto:
        return const Text('Mode: Auto');
      case AirConditionerMode.cool:
        return const Text('Mode: Cool');
      case AirConditionerMode.heat:
        return const Text('Mode: Heat');
      case AirConditionerMode.dry:
        return const Text('Mode: Dry');
      case AirConditionerMode.fan:
        return const Text('Mode: Fan');
    }
  }
  Widget _buildConnectionErrorUI() {
    // Implement UI for the connection error state.
    return const Center(
      child: Text('Failed to connect to the device. Please try again.'),
    );
  }
}