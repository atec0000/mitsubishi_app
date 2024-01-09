import 'package:get/get.dart';
import 'package:mitsubishi_app/common/index.dart';

class HomeDevicesController extends GetxController {
  HomeDevicesController();

  //用戶資料
  UserProfileModel profile = UserService.to.profile;
  // 家庭列表數據
  List<FamilyModel> familyList = [];
  // 設備列表數據
  List<Object> deviceList = [];

  _initData() async {
    var res = await UserApi.overveiw();
    //用戶資料
    profile = UserProfileModel.fromJson(res['user']);
    UserService.to.setProfile(profile);

    //家庭
    for (var item in res['families']) {
      familyList.add(FamilyModel.fromJson(item));
    }
    
    //group

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
