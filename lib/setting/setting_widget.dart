

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/static_style.dart';


Widget settingCard({
  required String title,
  // required String subtitle,
  required Color textColor,
  // required String imagePath,
  required Widget nextPage,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => nextPage,
        ),
      );
    },
    child:Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: ListTile(
                                trailing:InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => nextPage,
                                      ),
                                    );
                                  },
                                  child:Icon(
                                    Icons.navigate_next,
                                    color: textColor,
                                    size: 30,
                                  ),
                                ),
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // subtitle: Text(
                                //   subtitle,
                                //   style: TextStyle(
                                //     color: textColor,
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.normal,
                                //   ),
                                // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 5, top: 12),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: ClipOval(
              //       child: Container(
              //         child: Image.asset(
              //           imagePath,
              //           fit: BoxFit.fill,
              //           width: 75,
              //           height: 75,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget settingurl({
  required String title,
  required Color textColor,
  required Function() onTapFunction,
  required BuildContext context,
}) {
  return InkWell(
    onTap: onTapFunction,
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: ListTile(
                                title: InkWell(
                                  onTap: onTapFunction,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget settingWithSwitch({
  required Text title,
  required SwitchWidget switchWidget,
}) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 2, right: 2),
        child: Stack(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: title,
                                  ),
                                  switchWidget,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
// class MyCheckbox extends StatefulWidget {
//   final String label;
//
//   MyCheckbox({required this.label});
//
//   @override
//   _MyCheckboxState createState() => _MyCheckboxState();
// }
//
// class _MyCheckboxState extends State<MyCheckbox> {
//   bool isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           isChecked = !isChecked;
//
//           // 如果選中當前選項，取消其他選項的選中狀態
//           if (isChecked) {
//             for (MyCheckbox otherCheckbox in _getOtherCheckboxes()) {
//               otherCheckbox.isChecked = false;
//             }
//           }
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Container(
//               width: 25.0,
//               height: 25.0,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.blue,
//                 ),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: isChecked
//                   ? Icon(
//                 Icons.check,
//                 size: 20.0,
//                 color: Colors.blue,
//               )
//                   : null,
//             ),
//             SizedBox(width: 16.0),
//             Text(widget.label),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper function to get a list of other checkboxes in the same parent widget
//   List<MyCheckbox> _getOtherCheckboxes() {
//     List<MyCheckbox> otherCheckboxes = [];
//
//     if (mounted) {
//       // Check if the current state is still mounted to avoid errors
//       BuildContext? context = context;
//       if (context != null) {
//         context.visitAncestorElements((element) {
//           if (element is StatefulElement &&
//               element.widget is MyCheckbox &&
//               element != this.context) {
//             otherCheckboxes.add(element.widget as MyCheckbox);
//           }
//           return true;
//         });
//       }
//     }
//
//     return otherCheckboxes;
//   }
// }

class SettingWithRadioButton extends StatefulWidget {
  final String title;
  final String title2;
  final Function(int?) onValueChanged;

  SettingWithRadioButton({
    required this.title,
    required this.title2,
    required this.onValueChanged,
  });

  @override
  _SettingWithRadioButtonState createState() => _SettingWithRadioButtonState();
}

class _SettingWithRadioButtonState extends State<SettingWithRadioButton> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(widget.title),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      widget.onValueChanged(value as int?);
                                      setState(() {
                                        selectedOption = value as int?;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(widget.title2),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      widget.onValueChanged(value as int?);
                                      setState(() {
                                        selectedOption = value as int?;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> sendEmail(String emailAddress) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: emailAddress,
  );
  await launchUrl(launchUri);
}