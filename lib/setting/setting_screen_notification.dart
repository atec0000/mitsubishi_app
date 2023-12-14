import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

import '../widget/static_style.dart';


class SetNotification extends StatefulWidget{

  SetNotification({Key? key}) : super(key: key);

  @override
  _SetNotificationState createState() => _SetNotificationState();
}

class _SetNotificationState extends State<SetNotification> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知設定'),
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        settingWithSwitch(title: Text('接收推播'), switchWidget: SwitchWidget(value: true,)),
        settingWithSwitch(title: Text('狀態通知'), switchWidget: SwitchWidget(value: true,)),
        settingWithSwitch(title: Text('系統通知'), switchWidget: SwitchWidget(value: true,)),
        settingWithSwitch(title: Text('廣播通知'), switchWidget: SwitchWidget(value: true,)),
        settingWithSwitch(title: Text('申請通知'), switchWidget: SwitchWidget(value: true,)),
      ],
    );

  }

}