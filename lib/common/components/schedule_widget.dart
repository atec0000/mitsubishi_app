import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/common/index.dart';

class ScheduleItemWidget extends StatelessWidget {
  /// 点击事件
  final Function()? onTap;

  /// 模型
  final ScheduleModel model;

  /// 图片宽
  final double? imgWidth;

  /// 图片高
  final double? imgHeight;

  const ScheduleItemWidget(
    this.model, {
    Key? key,
    this.onTap,
    this.imgWidth,
    this.imgHeight,
  }) : super(key: key);

  Widget _buildView(BoxConstraints constraints) {
    var title = <Widget>[
      // 图片
      const Icon(Icons.album, color: Colors.cyan, size: 45),

      // 描述
      const TextWidget.title2('定時排程'),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
        .paddingHorizontal(15)
        .expanded();

    var body = <Widget>[
      const TextWidget.body1('今天13:00執行').paddingBottom(15),
      TextWidget.body1(model.name ?? "排程名稱").paddingBottom(5),
      TextWidget.body1(model.mac ?? "設備"),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .paddingHorizontal(15)
        .expanded();

    var tap = <Widget>[]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
        )
        .paddingTop(10)
        .expanded();

    var ws = <Widget>[title, body, tap]
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
      } else {
        // Get.toNamed(
        //   RouteNames.goodsProductDetails,
        //   arguments: {
        //     "id": model.id,
        //   },
        // );
      }
    });

    return SizedBox(
      height: 112,
      child: ws,
    );
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
