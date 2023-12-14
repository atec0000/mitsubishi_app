import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_customer_service.dart';
import 'package:mitsubishi_app/setting/setting_page.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';


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
          title: '聯絡我們',
          subtitle: '電話、郵件、線上報修',
          textColor: Colors.black,
          nextPage: Setservice(),
          context: context,
        ),
        SizedBox(height: 5,),
        settingCard(
          title: '系統設定',
          subtitle: '通知、介面、回饋、燈號',
          textColor: Colors.black,
          nextPage: SetPage(),
          context: context,
        ),




      ],
    );

  }

}