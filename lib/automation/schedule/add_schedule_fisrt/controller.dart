import 'package:get/get.dart';

class AddScheduleFisrtController extends GetxController {
  AddScheduleFisrtController();

  _initData() {
    update(["add_schedule_fisrt"]);
  }

  void onAdd(int tag) {

  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
