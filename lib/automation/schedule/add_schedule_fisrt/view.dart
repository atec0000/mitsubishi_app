import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/common/index.dart';
import 'package:mitsubishi_app/common/widgets/button.dart';

import 'index.dart';

class AddScheduleFisrtPage extends GetView<AddScheduleFisrtController> {
  const AddScheduleFisrtPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return  GetBuilder<AddScheduleFisrtController>(
      builder: (_){
        return <Widget>[
          <Widget>[
            const TextWidget.body2('定時排程的說明').paddingBottom(10),
            ButtonWidget.text(LocaleKeys.addScheduleTime.tr,
            onTap: ()=> controller.onAdd(0)),
          ].toColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            ).paddingTop(10),
          
          <Widget>[
            TextWidget.body2('週期排程的說明'),
            ButtonWidget.text(LocaleKeys.addScheduleTime.tr,
            onTap: ()=> controller.onAdd(1)),
          ].toColumn().paddingTop(10),
        ].toColumn().paddingLeft(15);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddScheduleFisrtController>(
      init: AddScheduleFisrtController(),
      id: "add_schedule_fisrt",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("add_schedule_fisrt")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
