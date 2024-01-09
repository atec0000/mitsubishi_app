import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mitsubishi_app/common/index.dart';

class DeviceItemWidget extends StatelessWidget {
  /// 点击事件
  final Function()? onTap;

  /// 模型
  final ScheduleModel model;

  /// 图片宽
  final double? imgWidth;

  /// 图片高
  final double? imgHeight;

  /// 是否打開
  final bool isOn;

  /// 选中事件
  final Function(bool)? onSelect;

  const DeviceItemWidget(
    this.model, {
    Key? key,
    required this.isOn,
    this.onTap,
    this.imgWidth,
    this.imgHeight,
    this.onSelect,
  }) : super(key: key);

  Widget _buildView(BoxConstraints constraints) {
    var title = <Widget>[
      // 图片
      const Icon(Icons.album, color: Colors.cyan, size: 30),

      // 描述
      const TextWidget.title2('定時排程'),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
        .paddingHorizontal(15)
        .expanded(flex: 3);

    var body = <Widget>[
      const TextWidget.body1('今天13:00執行').paddingBottom(5),
      TextWidget.body1(model.name ?? "排程名稱").paddingBottom(5),
      TextWidget.body1(model.mac ?? "設備"),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .paddingHorizontal(1)
        .expanded(flex: 4);

    var tap = <Widget>[
      CupertinoSwitch(
        value: isOn,
        onChanged: (isCheck) => onSelect!(isCheck),
      ),
      const TextWidget.body1("編輯").paddingRight(5),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
        )
        .paddingTop(10)
        .expanded(flex: 2);

    return <Widget>[title, body, tap]
        .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        // .backgroundColor(AppColors.onPrimary)
        .card(
          blurRadius: 1,
        )
        .padding(all: 5)
        .onTap(() {
      if (onTap != null) {
        onTap?.call();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _buildView(constraints);
      },
    );
  }
}
