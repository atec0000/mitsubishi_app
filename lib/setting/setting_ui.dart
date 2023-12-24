import 'package:flutter/material.dart';
import 'package:mitsubishi_app/setting/setting_widget.dart';

class SetUI extends StatefulWidget {
  const SetUI({Key? key}) : super(key: key);

  @override
  _SetUIState createState() => _SetUIState();
}

class _SetUIState extends State<SetUI> {
  int? selectedOption;
  int? selectedOption_2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('介面設定'),
        centerTitle: true,
      ),
      body: settingcard(),
    );
  }

  Widget settingcard() {
    return Column(
      children: [
        const Text('介面顏色'),
        MyCheckbox(
            label: '系統預設',
            isSelected: selectedOption == 1,
            onToggle: (isChecked) {
              setState(() {
                selectedOption = isChecked ? 1 : null;
              });
            }),
        MyCheckbox(
          label: '黑色模式',
          isSelected: selectedOption == 2,
          onToggle: (isChecked) {
            setState(() {
              selectedOption = isChecked ? 2 : null;
            });
          },
        ),
        MyCheckbox(
          label: '淺色模式',
          isSelected: selectedOption == 3,
          onToggle: (isChecked) {
            setState(() {
              selectedOption = isChecked ? 3 : null;
            });
          },
        ),
        const Text('介面語言'),
        MyCheckbox(
          label: '系統預設',
          isSelected: selectedOption_2 == 1,
          onToggle: (isChecked) {
            setState(() {
              selectedOption_2 = isChecked ? 1 : null;
            });
          },
        ),
        MyCheckbox(
          label: '中文',
          isSelected: selectedOption_2 == 2,
          onToggle: (isChecked) {
            setState(() {
              selectedOption_2 = isChecked ? 2 : null;
            });
          },
        ),
        MyCheckbox(
          label: '英文',
          isSelected: selectedOption_2 == 3,
          onToggle: (isChecked) {
            setState(() {
              selectedOption_2 = isChecked ? 3 : null;
            });
          },
        ),
        MyCheckbox(
          label: '日文',
          isSelected: selectedOption_2 == 4,
          onToggle: (isChecked) {
            setState(() {
              selectedOption_2 = isChecked ? 4 : null;
            });
          },
        ),
      ],
    );
  }
}
