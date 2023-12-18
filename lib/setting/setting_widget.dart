

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/static_style.dart';


Widget settingCard({
  required String title,
  // required String subtitle,
  required Color textColor,
  // required String imagePath,
  required Widget? nextPage,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      if (nextPage != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      }
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
                                    if (nextPage != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => nextPage,
                                        ),
                                      );
                                    }
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

Widget settingWithImfo({
  required String title,
  required String info,
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
                                    child: Text(
                                      title,
                                      style:TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                 Text(
                                   info,
                                   style: TextStyle(fontSize: 15,color: Colors.grey),
                                 ),
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
class MyCheckbox extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onToggle;

  MyCheckbox({required this.label, required this.onToggle, required this.isSelected,});

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // Only toggle the state if it's not already selected
          if (!widget.isSelected) {
            widget.onToggle(true);

            // Unselect other options
            for (MyCheckbox otherCheckbox in _getOtherCheckboxes()) {
              otherCheckbox.onToggle(false);
            }
          }
        });
      },
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
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child:  Text(widget.label,
                                          style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                      Container(
                                        child: widget.isSelected
                                            ? Icon(
                                          Icons.check,
                                          size: 30.0,
                                          color: Colors.blue,
                                        )
                                            : null,
                                      ),
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
      ),
    );
  }

  // Helper function to get a list of other checkboxes in the same parent widget
  List<MyCheckbox> _getOtherCheckboxes() {
    List<MyCheckbox> otherCheckboxes = [];

    if (mounted) {
      // Check if the current state is still mounted to avoid errors
      BuildContext? currentContext = context;
      if (currentContext != null) {
        currentContext.visitAncestorElements((element) {
          if (element is StatefulElement &&
              element.widget is MyCheckbox &&
              element != this.context) {
            otherCheckboxes.add(element.widget as MyCheckbox);
          }
          return true;
        });
      }
    }

    return otherCheckboxes;
  }

}

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