import 'package:flutter/cupertino.dart';
import 'package:mitsubishi_app/common/index.dart';


class GroupWidget extends StatelessWidget {
  ///設備列表
  //final List<ScheduleModel> scheduleList;

  /// 是否选中
  final bool isSelected;

  /// 选中事件
  final Function(bool)? onSelect;

  const GroupWidget({
    Key? key,
    //required this.scheduleList,
    required this.isSelected,
    this.onSelect,
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    var groupTitle = <Widget>[
      <Widget>[
        const TextWidget.body1("客廳").paddingLeft(10),
      ].toRow(),
      
      <Widget>[
        const TextWidget.body1("群組開關").paddingRight(5),
        CupertinoSwitch(
          value: isSelected, 
          onChanged: (isCheck)=>onSelect!(isCheck),    
        ).paddingRight(10),
      ].toRow(),
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
    ).paddingBottom(5);

    return <Widget>[
      groupTitle,

      ].toColumn();
  }
}