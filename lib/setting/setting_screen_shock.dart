import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

class SetShock extends StatefulWidget{

  SetShock({Key? key}) : super(key: key);

  @override
  _SetShockState createState() => _SetShockState();
}

class _SetShockState extends State<SetShock> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('震動設定'),
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        SettingWithRadioButton(title: '預設', title2: '關閉', onValueChanged: (int ) {})
      ],
    );

  }

}