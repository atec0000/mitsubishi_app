import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mitsubishi_app/screens/aircontrol_screen.dart';

import '../../bluetooth_pair/pageswitch_blufi.dart';
import '../../model/device.dart';
import '../../widget/static_style.dart';
import 'controller.dart';

class Device_card extends StatelessWidget {
  final DeviceController deviceController = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeviceController>(
      builder: (controller) => buildListView(controller.devices),
    );
  }

  Widget buildListView(List<Device> devices) {
    return GetBuilder<DeviceController>(
      init:
          DeviceController(), // Initialize your controller here if not done elsewhere
      initState: (_) {
        Get.find<DeviceController>().fetchDevices();
      },
      builder: (controller) {
        return ListView.builder(
          itemCount:
              (devices.length / 2).ceil() + (devices.length.isEven ? 1 : 0),
          itemBuilder: (context, rowIndex) {
            var startIndex = rowIndex * 2;
            var endIndex = startIndex + 2;
            endIndex = endIndex.clamp(0, devices.length);

            var cards = devices.sublist(startIndex, endIndex).map((device) {
              return buildCard(context, device);
            }).toList();

            // 在最後一行加入空白卡片中間有按鈕
            if (rowIndex == (devices.length / 2).floor()) {
              if (devices.length % 2 == 0 || devices.length.isOdd) {
                cards.add(
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: buildEmptyCardWithButton(() {
                        Get.to(() => PageSwitcher());
                      }),
                    ),
                  ),
                );
              }
              if (devices.isEmpty) {
                final emptyCardWithButton = buildEmptyCardWithButton(() {
                  Get.to(() => PageSwitcher());
                });

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '初次見面!請點擊"+"配對設備',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      const Text(
                        '正式開始你的智慧生活!',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      emptyCardWithButton,
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
      },
    );
  }

  Widget buildCard(BuildContext context, Device device) {
    double cardSize = MediaQuery.of(context).size.width * 0.5;
    return InkWell(
      borderRadius: BorderRadius.circular(25.0),
      onTap: () {
        Get.to(() => AircontrolScreen(deviceMac: device.mac));
      },
      onLongPress: () {
        // 執行刪除裝置的操作
        _showDeleteDialog(device);
      },
      child: SizedBox(
        height: cardSize,
        width: cardSize,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(197, 0, 39, 73),
                  Color.fromARGB(197, 0, 108, 253),
                ],
              ),
            ),
            child: buildCardContent(device),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(Device device) async {
    return Get.defaultDialog(
      title: '刪除裝置',
      content: const Text('確定要刪除裝置嗎？'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () async {
            // Perform the delete operation
            Get.back(); // Close the dialog
          },
          child: const Text('確定'),
        ),
      ],
    );
  }

  Widget buildEmptyCardWithButton(ButtonCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, right: 8.0),
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
            child: const Text(
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

  Widget buildCardContent(Device device) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              //   child: getAcModeText(AirConditionerMode.cool),
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                child: GetBuilder<DeviceController>(
                  builder: (controller) {
                    return SwitchWidget(
                      value: controller.power.value,
                      onChanged: (bool newValue) {
                        controller.togglePower(newValue, device.mac);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, bottom: 8.0), // Added bottom padding
              child: Text(
                "26°C ",
                style: const TextStyle(fontSize: 45, color: Colors.lightBlue),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, bottom: 16.0), // Added bottom padding
              child: Text(
                "MHCAD_${device.mac.substring(device.mac.length - 4)}",
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
