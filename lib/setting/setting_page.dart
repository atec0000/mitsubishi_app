import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_screen_led.dart';
import 'package:mitsubishi_app/setting/setting_screen_notification.dart';
import 'package:mitsubishi_app/setting/setting_screen_shock.dart';
import 'package:mitsubishi_app/setting/setting_screen_theme.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';


class SetPage extends StatefulWidget{

  SetPage({Key? key}) : super(key: key);

  @override
  _SetPageState createState() => _SetPageState();
  }

  class _SetPageState extends State<SetPage> {


  @override
  void initState() {
  super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系統設定'),
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        settingCard(
          title: '通知設定',
          subtitle: '推播、狀態、系統、廣播、申請',
          textColor: Colors.black,
          nextPage: SetNotification(),
          context: context,
        ),
        SizedBox(height: 5),
        settingCard(
          title: '主題設定',
          subtitle: '深淺色',
          textColor: Colors.black,
          nextPage: SetTheme(),
          context: context,
        ),
        SizedBox(height: 5),
        settingCard(
          title: '震動設定',
          subtitle: '預設、關閉',
          textColor: Colors.black,
          nextPage: SetShock(),
          context: context,
        ),
        SizedBox(height: 5),
        settingCard(
          title: '燈號設定',
          subtitle: '預設、關閉',
          textColor: Colors.black,
          nextPage: SetLED(),
          context: context,
        ),
      ],
    );
  }
}