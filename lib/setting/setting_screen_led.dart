import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

class SetLED extends StatefulWidget{

  SetLED({Key? key}) : super(key: key);

  @override
  _SetLEDState createState() => _SetLEDState();
}

class _SetLEDState extends State<SetLED> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('燈號設定'),
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