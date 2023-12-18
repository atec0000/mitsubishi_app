import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

import '../widget/static_style.dart';


class SetNotification extends StatefulWidget{

  SetNotification({Key? key}) : super(key: key);

  @override
  _SetNotificationState createState() => _SetNotificationState();
}

class _SetNotificationState extends State<SetNotification> {
  bool set_1 = false;
  bool set_2 = false;
  bool set_3 = false;
  bool set_4 = false;
  bool set_5 = false;

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('推播設定'),
        centerTitle: true,
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        settingWithSwitch(
          title: Text('推播設定'),
          switchWidget: SwitchWidget(
            value: set_1,
            onChanged: (bool newValue) {
              setState(() {
                set_1 = newValue;
              });
            },
          ),
        ),
        settingWithSwitch(title: Text('狀態通知'),
            switchWidget: SwitchWidget(
              value: set_2,
              onChanged: (bool newValue) {
                setState(() {
                  set_2 = newValue;
                });
              },
            )
        ),
        settingWithSwitch(title: Text('系統通知'),
            switchWidget: SwitchWidget(
              value: set_3,
              onChanged: (bool newValue) {
                setState(() {
                  set_3 = newValue;
                });
              },
            )
        ),
        settingWithSwitch(title: Text('廣播通知'),
            switchWidget: SwitchWidget(
              value: set_4,
              onChanged: (bool newValue) {
                setState(() {
                  set_4 = newValue;
                });
              },
            )
        ),
        settingWithSwitch(title: Text('申請通知'), switchWidget: SwitchWidget(
          value: set_5,
          onChanged: (bool newValue) {
            setState(() {
              set_5 = newValue;
            });
          },
        )
        ),
      ],
    );

  }

}
