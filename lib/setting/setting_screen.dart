import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_app_info.dart';
import 'package:mitsubishi_app/setting/setting_customer_service.dart';
import 'package:mitsubishi_app/setting/setting_product_service.dart';
import 'package:mitsubishi_app/setting/setting_screen_notification.dart';
import 'package:mitsubishi_app/setting/setting_ui.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

import '../widget/static_style.dart';

class SetScreen extends StatefulWidget {
  const SetScreen({Key? key}) : super(key: key);

  @override
  _SetScreenState createState() => _SetScreenState();
}

class _SetScreenState extends State<SetScreen> {
  bool set_1 = false;
  bool set_2 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: settingcard(),
        ));
  }

  Widget settingcard() {
    return Column(
      children: [
        settingCard(
          title: '個人資料',
          textColor: Colors.black,
          nextPage: null,
          context: context,
        ),
        const Text(
          '系統設定',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 5,
        ),
        settingCard(
          title: '推播設定',
          textColor: Colors.black,
          nextPage: const SetNotification(),
          context: context,
        ),
        settingCard(
          title: '介面設定',
          textColor: Colors.black,
          nextPage: const SetUI(),
          context: context,
        ),
        settingWithSwitch(
            title: const Text(
              '震動回饋',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            switchWidget: SwitchWidget(
              value: set_1,
              onChanged: (bool newValue) {
                setState(() {
                  set_1 = newValue;
                });
              },
            )),
        settingWithSwitch(
            title: const Text('裝置指示燈',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            switchWidget: SwitchWidget(
              value: set_2,
              onChanged: (bool newValue) {
                setState(() {
                  set_2 = newValue;
                });
              },
            )),
        settingCard(
          title: '系統資訊',
          textColor: Colors.black,
          nextPage: SetAppinformation(),
          context: context,
        ),
        settingCard(
          title: '使用條款',
          textColor: Colors.black,
          nextPage: null,
          context: context,
        ),
        settingCard(
          title: '產品服務',
          textColor: Colors.black,
          nextPage: const SetPorductservice(),
          context: context,
        ),
        settingCard(
          title: '聯絡我們',
          textColor: Colors.black,
          nextPage: const Setservice(),
          context: context,
        ),
      ],
    );
  }
}
