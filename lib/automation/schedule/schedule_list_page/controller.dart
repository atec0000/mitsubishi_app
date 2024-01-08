import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/automation/schedule/add_schedule_fisrt/index.dart';
import 'package:mitsubishi_app/common/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScheduleListPageController extends GetxController {
  ScheduleListPageController();

  bool isOpen = false;
  // 外出模式列表數據
  List<Object> goOutModeList = [];
  // 排程列表數據
  List<ScheduleModel> scheduleList = [
    ScheduleModel(name: '冷氣1', isOn: true),
    ScheduleModel(name: '冷氣2', isOn: false)
  ];

  // 刷新控制器
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  /// 拉取数据
  /// isRefresh 是否是刷新
  Future<bool> _loadNewsSell(bool isRefresh) async {
    // 拉取数据

    // 下拉刷新
    if (isRefresh) {
      //_page = 1; // 重置页数1
      //scheduleList.clear();
      goOutModeList.clear(); // 清空数据
    }

    // 有数据
    if ([].isNotEmpty) {
      // 添加数据
      //newProductProductList.addAll(result);
    }

    // 是否空
    return [].isEmpty;
  }

  _initData() async {
    await Future.delayed(const Duration(seconds: 1));
    update(["schedule"]);
  }

  // 下拉刷新
  void onRefresh() async {
    try {
      await _loadNewsSell(true);
      refreshController.refreshCompleted();
    } catch (error) {
      refreshController.refreshFailed();
    }
    update(["schedule_list"]);
  }

  //排程開關
  void onSelect(int positin, bool isSelected) {
    print('object');
    scheduleList[positin].isOn = isSelected;
    if (isSelected) {
      
      //selectedIds.add(productId);
    } else {
      
      //selectedIds.remove(productId);
    }
    update(["schedule_list"]);
  }

  void onHomeList(bool open) {
    isOpen = open;
    
    update(["schedule_home"]);
  }

  void onAdd() {
    Get.bottomSheet(
      <Widget>[
        const SizedBox(height: 30,),
        for(ScheduleModel model in scheduleList)
          Text(model.name??'')
          .onTap(() {
            print(model.name);
          }).paddingLeft(15)
          .paddingTop(5)
      ].toListView()

    );
    //Get.to(() =>const AddScheduleFisrtPage());
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();

    refreshController.dispose();
  }
}
