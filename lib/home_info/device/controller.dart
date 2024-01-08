import 'package:get/get.dart';
import 'package:mitsubishi_app/model/device.dart';

import '../../service/api_service.dart';
import '../../service/command_parser_ca51.dart';
import '../../service/mqtt_service.dart';



class DeviceController extends GetxController{
  var devices = <Device>[].obs;
  var power = false.obs;
  final ApiService _apiService = ApiService();

  Future<void> fetchDevices() async {
    try {
      final List<Device> deviceList = await _apiService.getDevices();
      devices.value = deviceList;
    } catch (e) {
      // Handle errors
      print('Error fetching devices: $e');
    }
  }

  void togglePower(bool newvalue, String deviceMac) {
    power.value = newvalue;
    if (newvalue) {
      publishHexMessage(air_poweron,deviceMac);
    } else {
      publishHexMessage(air_poweroff,deviceMac);
    }
  }


}