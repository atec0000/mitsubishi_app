import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/common/index.dart';

import 'index.dart';

class HomeDevicesPage extends StatefulWidget {
  const HomeDevicesPage({Key? key}) : super(key: key);

  @override
  State<HomeDevicesPage> createState() => _HomeDevicesPageState();
}

class _HomeDevicesPageState extends State<HomeDevicesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _HomeDevicesViewGetX();
  }
}

class _HomeDevicesViewGetX extends GetView<HomeDevicesController> {
  const _HomeDevicesViewGetX({Key? key}) : super(key: key);

  Widget _buildDevices() {
    return GetBuilder<HomeDevicesController>(
      id: "device_list",
      builder: (_) {
        return const GroupWidget(isSelected: true,);
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return  <Widget>[
      const TextWidget.title1('Jeffery'),
        //家庭條

        //設備列表橫向

        //設備列表資料
        _buildDevices(),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDevicesController>(
      init: HomeDevicesController(),
      id: "home_devices",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
