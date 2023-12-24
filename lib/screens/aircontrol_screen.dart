import 'dart:async';

import 'package:mitsubishi_app/model/ac_status_ca51.dart';
import 'package:mitsubishi_app/service/command_parser_ca51.dart';
import 'package:mitsubishi_app/widget/static_style.dart';
import 'package:flutter/material.dart';

import 'package:mitsubishi_app/service/tcp_service.dart';

import '../service/receive_data.dart';

class AircontrolScreen extends StatefulWidget {
  final String deviceMac;

  const AircontrolScreen({super.key, required this.deviceMac});

  @override
  _AircontrolScreenState createState() => _AircontrolScreenState();
}

class _AircontrolScreenState extends State<AircontrolScreen> {
  final TcpService _tcpService = TcpService();
  bool isConnecting = false;
  bool connectionSuccess = false;
  final AcStatusCa51 _acStatus = AcStatusCa51.off();
  DataProcessing dataProcessing = DataProcessing();
  Timer? _debounce;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('Getting devices');
    connectToDevice();
  }

  @override
  void dispose() {
    super.dispose();
    _tcpService.disconnect();
  }

  void connectToDevice() async {
    setState(() {
      isConnecting = true; // Set connecting state to true
    });

    final connected = await _tcpService.connectToServer(widget.deviceMac);
    List<int> codeset = idToCode(0x01, 114); // Pass the int to the function
    _tcpService.sendCommand(codeset);

    setState(() {
      isConnecting = false; // Set connecting state to false after the attempt
      connectionSuccess = connected;
    });

    if (connected) {
      dataProcessing.initCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // 设置返回键颜色
        ),
        backgroundColor: Colors.black,
        title: const Text(
          '臥室冷氣',
          style: TextStyle(color: Colors.white),
        ),
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
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SwitchWidget(
                    value: _acStatus.power,
                    onChanged: (bool newvalue) {
                      if (newvalue) {
                        _tcpService
                            .sendCommand(get_TaiSEIA_other('80', 1, '01'));
                      } else {
                        _tcpService
                            .sendCommand(get_TaiSEIA_other('80', 1, '00'));
                      }
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20), // Adjust the top margin as needed
              child: CustomSlider(
                value: newAirtemperatureValue,
                min: _acStatus.power ? 16.0 : 0,
                max: 30.0,
                onChanged: (newvalue) {
                  if (_acStatus.power) {
                    if (newvalue < 16.0) {
                      newvalue = 16.0;
                    }
                  }
                  setState(() {
                    newAirtemperatureValue = newvalue;
                    AirtemperatureValue = newvalue.toInt();
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
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          '${temperature.toInt()}°C',
                          style: const TextStyle(
                              fontSize: 30, color: Colors.blueAccent),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '室內溫度',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5), // Reduced width
                  Container(
                    height: 30,
                    width: 3,
                    color: const Color.fromARGB(250, 59, 56, 56),
                  ),
                  const SizedBox(width: 5), // Reduced width
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          '${humidity.toInt()}%',
                          style: const TextStyle(
                              fontSize: 30, color: Colors.blueAccent),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '室外溫度',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Theam().buildCustomGradientRectangle(
              context,
              [
                Column(
                  children: [
                    const Text(
                      '模       式',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildModeIconButton(2, Icons.ac_unit, '00'),
                        const SizedBox(width: 35),
                        buildModeIconButton(5, Icons.wind_power, '02'),
                        const SizedBox(width: 35),
                        buildModeIconButton(4, Icons.water_drop, '01'),
                        const SizedBox(width: 35),
                        buildModeIconButton(3, Icons.sunny, '04'),
                        const SizedBox(width: 35),
                        buildModeIconButton(1, Icons.hdr_auto, '03'),
                      ],
                    ),
                  ],
                ),
              ],
              80,
              30,
            ),
            const SizedBox(
              height: 3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theam().buildCustomRectangle(
                    context, "風   速", _acStatus.windSpeed, Icons.air, () {
                  _tcpService.sendCommand(get_windspeed(5));
                }),
                Theam().buildCustomRectangle(context, "上下風向",
                    _acStatus.windDirectionud, Icons.arrow_upward, () {
                  get_winddirection_updown(17);
                }),
                Theam().buildCustomRectangle(context, "左右風向",
                    _acStatus.windDirectionlr, Icons.arrow_forward, () {
                  _tcpService.sendCommand(get_winddirection_leftright(17));
                }),
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

  Object getAcModeText(AirConditionerMode mode) {
    switch (mode) {
      case AirConditionerMode.auto:
        return 1;
      case AirConditionerMode.cool:
        return 2;
      case AirConditionerMode.heat:
        return 3;
      case AirConditionerMode.dry:
        return 4;
      case AirConditionerMode.fan:
        return 5;
    }
  }

  Widget buildModeIconButton(int mode, IconData icon, String command) {
    return buildIconButton(
      icon,
      () {
        _tcpService.sendCommand(get_TaiSEIA_other('81', 1, command));
      },
      iconColor:
          getAcModeText(_acStatus.mode) == mode ? Colors.white : Colors.grey,
    );
  }

  Widget _buildConnectionErrorUI() {
    // Implement UI for the connection error state.
    return const Center(
      child: Text('Failed to connect to the device. Please try again.'),
    );
  }
}
