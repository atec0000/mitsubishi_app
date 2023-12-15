import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_customer_service.dart';
import 'package:mitsubishi_app/setting/setting_screen_notification.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

import '../widget/static_style.dart';


class SetScreen extends StatefulWidget{

  SetScreen({Key? key}) : super(key: key);

  @override
  _SetScreenState createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        settingCard(
          title: '個人資料',
          textColor: Colors.black,
          nextPage: Setservice(),
          context: context,
        ),

        Text('系統設定',style: TextStyle(fontSize: 20 ), textAlign: TextAlign.left,),
        SizedBox(height: 5,),
        settingCard(
          title: '推播設定',
          textColor: Colors.black,
          nextPage: SetNotification(),
          context: context,
        ),
        settingCard(
          title: '介面設定',
          textColor: Colors.black,
          nextPage: SetNotification(),
          context: context,
        ),
        settingWithSwitch(title: Text('震動回饋',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),), switchWidget: SwitchWidget(value: true,)),
        settingWithSwitch(title: Text('裝置指示燈',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)), switchWidget: SwitchWidget(value: true,)),
        settingCard(
          title: '系通資訊',
          textColor: Colors.black,
          nextPage: SetNotification(),
          context: context,
        ),
        settingCard(
          title: '使用條款',
          textColor: Colors.black,
          nextPage:SetNotification(),
          context: context,
        ),
        settingCard(
          title: '產品服務',
          textColor: Colors.black,
          nextPage: SetNotification(),
          context: context,
        ),
        settingCard(
          title: '聯絡我們',
          textColor: Colors.black,
          nextPage: Setservice(),
          context: context,
        ),

      ],
    );

  }

}