import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/common/index.dart';

class HomeListWidget extends StatelessWidget {
  /// 点击事件
  final Function(bool)? onTap;

  /// 模型
  final model;

  /// 是否展開
  final bool isOpen;

  /// 高
  final double? imgHeight;

  const HomeListWidget({
    Key? key,
    this.model,
    this.isOpen = false,
    this.imgHeight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = <Widget>[
      const TextWidget.body1('家庭一').paddingAll(15),
      Icon((isOpen) ? Icons.arrow_drop_up : Icons.arrow_drop_down),
    ].toRow().onTap(() {
      if (onTap != null) {
        bool a = !isOpen;
        onTap!(a);
      }
    });
    return <Widget>[
      title,
      //isOpen ?
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }
}
