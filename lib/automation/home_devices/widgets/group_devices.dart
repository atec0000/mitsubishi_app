import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mitsubishi_app/common/index.dart';

class GroupWidget extends StatelessWidget {
  ///設備列表
  //final List<ScheduleModel> scheduleList;

  /// 是否展開
  final bool isOpen;

  /// 展開事件
  final Function(bool)? onOpen;

  /// 是否选中
  final bool isSelected;

  /// 选中事件
  final Function(bool)? onSelect;

  const GroupWidget({
    Key? key,
    //required this.scheduleList,
    this.isOpen = true,
    this.onOpen,
    required this.isSelected,
    this.onSelect,
  }) : super(key: key);

  Widget groupList() {
    return <Widget>[
      Text('11'),
      Text('22'),
    ].toListView();
  }

  @override
  Widget build(BuildContext context) {
    var groupTitle = <Widget>[
      <Widget>[
        Icon((isOpen) ? Icons.arrow_drop_up : Icons.arrow_drop_down)
            .paddingLeft(10)
            .onTap(() => onOpen!(!isOpen)),
        const TextWidget.body1("客廳").paddingLeft(5),
      ].toRow(),
      <Widget>[
        const TextWidget.body1("群組開關").paddingRight(5),
        CupertinoSwitch(
          value: isSelected,
          onChanged: (isCheck) => onSelect!(isCheck),
        ).paddingRight(10),
      ].toRow(),
    ]
        .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
        .paddingBottom(5);

    return isOpen
        ? <Widget>[
            groupTitle,
            groupList(),
          ].toColumn()
        : groupTitle;
  }
}
