import 'package:get/get.dart';

class HomeDevicesController extends GetxController {
  HomeDevicesController();

  // 家庭列表數據
  List<Object> FamilyList = [];
  // 設備列表數據
  List<Object> deviceList = [];

  _initData() {
    update(["home_devices"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
