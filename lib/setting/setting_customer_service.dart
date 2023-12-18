import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';


class Setservice extends StatefulWidget{

  Setservice({Key? key}) : super(key: key);

  @override
  _SetserviceState createState() => _SetserviceState();
}

class _SetserviceState extends State<Setservice> {


  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聯絡我們'),
        centerTitle: true,
      ),
      body: settingcard(),
    );
  }

  Widget settingcard(){
    return Column(
      children: [
        settingurl(
            title: '電話聯繫',
            textColor: Colors.black,
            onTapFunction: () { makePhoneCall('0966666666'); },
            context: context
        ),
        SizedBox(height: 3,),
        settingurl(
            title: '郵件聯繫',
            textColor: Colors.black,
            onTapFunction: () { sendEmail('mitsubishi@gmail.com'); },
            context: context
        ),

      ],
    );

  }

}