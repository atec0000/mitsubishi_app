import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

class SetTheme extends StatefulWidget{

  SetTheme({Key? key}) : super(key: key);

  @override
  _SetThemeState createState() => _SetThemeState();
}

class _SetThemeState extends State<SetTheme> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主題設定'),
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        SettingWithRadioButton(title: '深色模式', title2: '淺色模式', onValueChanged: (int ) {})
      ],
    );

  }

}