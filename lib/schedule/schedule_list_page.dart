import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class ScheduleMainPage extends StatefulWidget {
  const ScheduleMainPage({super.key});


  @override
  _ScheduleMainPageState createState() => _ScheduleMainPageState();

}

class _ScheduleMainPageState extends State<ScheduleMainPage>{
  bool isLoading = false;
  List<bool> checkList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,

      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children:[
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:Text('外出模式',
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                        //color: color3,
                      ),
                    ),)
                ],
              ),

              SizedBox(
                height: 190.0,
                child: SingleChildScrollView(
                  scrollDirection:Axis.horizontal,
                  child: IntrinsicWidth(
                    child: Row(
                      children: modeCard(),
                      // [
                      //   Container(color: Colors.greenAccent,width: 200,),
                      //   Container(color: Colors.blue,width: 200,)
                      // ],//buildCard(),
                    ),
                  ),
                ),
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:Text('排程控制',
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),)
                ],
              ),
              Expanded(child:
                SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Column(
                      children: buildCard(),
                    ),
                  ),
                ),
                // Column(children: buildCard(),)
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  minimumSize: const Size(353, 56),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  )
                ),
                onPressed: (){
                  addNew();
                },

                child: const Text('+'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> modeCard() {
    List<Widget> cardList = [];
    for(int i = 0 ; i<3; i++){

      Widget wc = SizedBox(
        width: 250,
        child: itemCard(i),
      );
      cardList.add(wc);
    }
    
    return cardList;
  }

  List<Card> buildCard() {
    List<Card> cardList = [];
    for(int i = 0 ; i<4; i++){
      cardList.add(itemCard(i));
    }
    return cardList;
  }

  Card itemCard(int a) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.green[100],
      shadowColor: Colors.blueGrey,
      elevation: 10,
      child:  Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Expanded(
            child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                leading: Icon (
                    Icons.album,
                    color: Colors.cyan,
                    size: 45
                ),
                title: Text(
                  "排程名稱",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('開啟冷氣'),
              ),

              ButtonBarTheme ( // make buttons use the appropriate styles for cards
                data: const ButtonBarThemeData(),
                child: ButtonBar(
                  children: [
                    TextButton(
                      child: const Text('Add '),
                      onPressed: (){},
                    ),

                  ],
                ),
              ),
            ],
          ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CupertinoSwitch(value: checkList[a], onChanged: (isCheck) {
                setState(() {
                  checkList[a] = isCheck;
                });
              }),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                child: const Text('More'),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const ();
                  // }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addNew(){
    //Get.to(() => const LoginPostScreen(""));
  }
}