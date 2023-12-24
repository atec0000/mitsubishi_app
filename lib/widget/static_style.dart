import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../bluetooth_pair/bluetooth_screen.dart';
import '../model/ac_status_ca51.dart';
import '../service/command_parser_ca51.dart';
import '../service/tcp_service.dart';

AcStatusCa51 _acStatus = AcStatusCa51.off();
final TcpService _tcpService = TcpService();
//這裡是一些靜態部件的集合
typedef ButtonCallback = void Function();
typedef VoidCallback = void Function();

class Theam {
  LinearGradient buildGradient(Color color1, Color color2,
      AlignmentGeometry startAlignment, AlignmentGeometry endAlignment) {
    return LinearGradient(
      colors: [color1, color2],
      begin: startAlignment,
      end: endAlignment,
    );
  }

  static Widget fan_button_as(
      BuildContext context, String buttonText, VoidCallback onPressed) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Material(
          borderRadius: BorderRadius.circular(20.0),
          elevation: 5,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () {
              onPressed();
              // 在這裡執行導航
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BluetoothScreen(),
                ),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // 設置按鈕形狀為圓形
                color: Colors.grey,
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget signup_Buttons(
      String text, BuildContext context, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed, // 将外部传递的函数设置为按钮的 onPressed
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 194, 46, 99),
        textStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
      child: Text(text),
    );
  }

  static Widget login_Buttons(
      String text, BuildContext context, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed, // 将外部传递的函数設置为按钮的 onPressed
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 194, 46, 99),
        textStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
      child: Text(text),
    );
  }

  Widget next_step_Buttons(
      String text, BuildContext context, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed, // 将外部传递的函数设置为按钮的 onTap
      child: Container(
        width: 250, // 设置按钮的宽度
        height: 50, // 设置按钮的高度
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 13, 102, 204),
              Color.fromARGB(255, 0, 39, 73),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static Widget fan_button(
      BuildContext context, String buttonText, ButtonCallback onPressed) {
    return StatefulBuilder(
      builder: (context, setState) {
        Color splashColor = Colors.black12;
        double elevation = 5;
        bool isPressed = false;

        return Material(
          borderRadius: BorderRadius.circular(20.0),
          elevation: elevation,
          child: Ink(
            decoration: BoxDecoration(
              // color: isPressed ? Colors.black12 : Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                setState(() {
                  isPressed = !isPressed;
                  elevation = isPressed ? 15 : 5;
                });
                onPressed(); // 触发按钮的回调
              },
              splashFactory: InkRipple.splashFactory,
              splashColor: splashColor,
              onHighlightChanged: (value) {
                setState(() {
                  isPressed = value;
                  splashColor = isPressed ? Colors.black38 : Colors.black12;
                });
              },
              child: Container(
                width: 300,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black12, // 设置背景颜色为透明
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 15,
                      color: isPressed ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCustomRectangle_2(
    BuildContext context,
    List<Widget> children,
    double height,
    double horizontalMargin,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 3),
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: Color.fromARGB(168, 51, 51, 59),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0), // Adjust as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget buildCustomRectangle(
    //這是風量風向選擇
    BuildContext context,
    String title,
    dynamic status,
    IconData iconData,
    VoidCallback rightArrowCallback,
  ) {
    return Theam().buildCustomRectangle_2(
      context,
      [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.keyboard_arrow_left_outlined,
          color: Colors.white,
          size: 15,
        ),
        const SizedBox(width: 10),
        Text(
          status.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: rightArrowCallback,
          child: const Icon(
            Icons.chevron_right_outlined,
            color: Colors.white,
            size: 15,
          ),
        ),
      ],
      60,
      30,
    );
  }

  Widget buildCustomRectangleSwitch(
    //定時switch開關
    BuildContext context,
    String title,
  ) {
    return Theam().buildCustomRectangle_2(
      context,
      [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(width: 50),
        SwitchWidget(
          value: _acStatus.timer > 0,
          onChanged: (newValue) {
            if (newValue) {
              _tcpService.sendCommand(get_TaiSEIA_other('8b', 1, '3c'));
            } else {
              _tcpService.sendCommand(get_TaiSEIA_other('8c', 1, '3c'));
            }
          },
        )
      ],
      60,
      30,
    );
  }

  Widget buildCustomGradientRectangle(
    BuildContext context, //模式選擇
    List<Widget> children,
    double height,
    double horizontalMargin,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 5),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(197, 4, 57, 110), // Start color
              Color.fromARGB(197, 0, 108, 253), // End color
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Center text vertically
            children: children,
          ),
        ),
      ),
    );
  }
}

class CustomSlider_2 extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double divisions;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangedEnd;

  const CustomSlider_2({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    this.onChanged,
    this.onChangedEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4.0,
        activeTrackColor: Colors.green,
        thumbColor: Colors.white,
      ),
      child: Transform.scale(
        scale: 1.5, // Adjust the scale factor as needed
        child: SleekCircularSlider(
          min: min,
          max: max,
          initialValue: value,
          onChange: onChanged,
          onChangeEnd: onChangedEnd,
          appearance: CircularSliderAppearance(
            customWidths: CustomSliderWidths(
              trackWidth: 10.0,
              progressBarWidth: 15.0,
            ),
            customColors: CustomSliderColors(
              trackColor: const Color.fromARGB(250, 59, 56, 56),
              progressBarColors: [
                const Color.fromARGB(197, 0, 108, 253),
                const Color.fromARGB(197, 0, 39, 73),
              ],
            ),
            infoProperties: InfoProperties(
              modifier: (value) => '${value.toInt()}°C',
              mainLabelStyle: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            startAngle: 0,
            angleRange: 360,
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangedEnd;
  final bool powerOn;
  final bool isLoading;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    this.onChanged,
    this.onChangedEnd,
    required this.powerOn,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading || (powerOn && value < 16)) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4.0,
          activeTrackColor: Colors.green,
          thumbColor: Colors.white,
        ),
        child: Transform.scale(
          scale: 1.5, // Adjust the scale factor as needed
          child: SleekCircularSlider(
            min: min,
            max: max,
            initialValue: powerOn ? value : 0,
            onChange: onChanged,
            onChangeEnd: onChangedEnd,
            appearance: CircularSliderAppearance(
              customWidths: CustomSliderWidths(
                trackWidth: 10.0,
                progressBarWidth: 15.0,
              ),
              customColors: CustomSliderColors(
                trackColor: const Color.fromARGB(250, 59, 56, 56),
                progressBarColors: [
                  const Color.fromARGB(197, 0, 108, 253),
                  const Color.fromARGB(197, 0, 39, 73),
                ],
              ),
              infoProperties: InfoProperties(
                modifier: (value) => powerOn ? '${value.toInt()}°C' : '0',
                mainLabelStyle: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              startAngle: 0,
              angleRange: 360,
            ),
          ),
        ),
      );
    }
  }
}

Widget buildDivider(
    double height, Color color, double leftPadding, double rightPadding) {
  return Padding(
    padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
    child: Divider(
      height: height,
      color: color,
    ),
  );
}

Widget buildShortVerticalDivider(double thickness, double height, Color color) {
  return Container(
    height: height,
    width: thickness,
    color: color,
  );
}

Widget buildDividerWithText(double height, Color color, double leftPadding,
    double rightPadding, String text) {
  return Padding(
    padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
    child: Row(
      children: [
        Expanded(
          child: Divider(
            height: height,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        ),
        Expanded(
          child: Divider(
            height: height,
            color: color,
          ),
        ),
      ],
    ),
  );
}

ButtonStyle customButtonStyle({required Color backgroundColor}) {
  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor,
  );
}

class SwitchRound extends StatelessWidget {
  const SwitchRound({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100.0),
            onTap: null, // Set onTap to null if you don't want it
            child: Container(
              width: 150,
              height: 150,
              color: const Color.fromARGB(205, 8, 48, 98),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildIconButton(IconData icon, VoidCallback onTap,
    {required Color iconColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(icon, size: 30, color: Colors.white),
        const SizedBox(height: 5), // 添加垂直間距
      ],
    ),
  );
}

class SwitchWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SwitchWidget({Key? key, required this.value, this.onChanged})
      : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return buildSwitch();
  }

  Widget buildSwitch() {
    return FlutterSwitch(
      width: 80.0,
      height: 40.0,
      valueFontSize: 16.0,
      toggleSize: 30.0,
      value: widget.value,
      borderRadius: 20.0,
      padding: 4.0,
      activeColor: Colors.blueAccent,
      showOnOff: true,
      onToggle: (val) {
        setState(() {
          // 不再直接改變內部的 status，而是通過回調向外部傳遞
          widget.onChanged?.call(val);
        });
      },
    );
  }
}
