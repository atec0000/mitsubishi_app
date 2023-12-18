import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';


class SetPorductservice extends StatefulWidget{

  SetPorductservice({Key? key}) : super(key: key);

  @override
  _SetPorductserviceState createState() => _SetPorductserviceState();
}

class _SetPorductserviceState extends State<SetPorductservice> {

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('產品服務'),
        centerTitle: true,
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        settingurl(
          title: '產品保固',
          textColor: Colors.black,
          onTapFunction: () {},
          context: context,
        ),
        settingurl(
          title: '常見問題',
          textColor: Colors.black,
          onTapFunction: () {},
          context: context,
        ),
        settingurl(
          title: '疑難排解',
          textColor: Colors.black,
          onTapFunction: () {},
          context: context,
        ),
        settingurl(
          title: '錯誤代碼',
          textColor: Colors.black,
          onTapFunction: () {},
          context: context,
        ),
      ],
    );

  }

}
