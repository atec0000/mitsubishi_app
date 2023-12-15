import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

class SetUI extends StatefulWidget{

  SetUI({Key? key}) : super(key: key);

  @override
  _SetUIState createState() => _SetUIState();
}

class _SetUIState extends State<SetUI> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('介面設定'),
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [

      ],
    );

  }

}