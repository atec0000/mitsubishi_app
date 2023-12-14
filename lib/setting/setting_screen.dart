import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_page.dart';

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
    //     settingCard(
    //   title: '聯絡我們',
    //   gradientStartColor: Color.fromARGB(197, 0, 108, 253),
    //   gradientEndColor: Color.fromARGB(197, 0, 39, 73),
    //   textColor: Colors.white,
    //   imagePath: 'assets/service.jpg',
    //   nextPage: null,
    //   context: context,
    // ),
    //     SizedBox(height:10),
    //     settingCard(
    //       title: '產品服務',
    //       gradientStartColor: Color.fromARGB(197, 253, 143, 0),
    //       gradientEndColor: Color.fromARGB(197, 126, 60, 0),
    //       textColor: Colors.white,
    //       imagePath: 'assets/air.jpg',
    //       context: context,
    //       nextPage: null,
    //     ),
    //     SizedBox(height:10),
        settingCard(
          title: '系統設定',
          subtitle: '通知、介面、回饋、燈號',
          imagePath: 'assets/set.jpg',
          textColor: Colors.black,
          nextPage: SetPage(),
          context: context,
        ),

      ],
    );

  }

}