import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mitsubishi_app/common/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'index.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _ScheduleListPageViewGetX();
  }
}

class _ScheduleListPageViewGetX extends GetView<ScheduleListPageController> {
  const _ScheduleListPageViewGetX({Key? key}) : super(key: key);

  Widget _buildSchedules() {
    return GetBuilder<ScheduleListPageController>(
      id: "schedule_list",
      builder: (_) {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int position) {
              var scheduleItem = controller.scheduleList[position];
              return ScheduleItemWidget(scheduleItem);
            },
            childCount: controller.scheduleList.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: AppSpace.listRow,
            crossAxisSpacing: AppSpace.listItem,
            childAspectRatio: 3.1,
          ),
        )
            .sliverPadding(bottom: AppSpace.page)
            .sliverPaddingHorizontal(AppSpace.page);
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return CustomScrollView(
      slivers: [
        //家庭條

        // 栏位标题
        controller.scheduleList.isNotEmpty
            ? const TextWidget.title2('外出模式')                   
                .sliverToBoxAdapter()
                .sliverPaddingHorizontal(AppSpace.page)
            : const SliverToBoxAdapter(),

        //外出列表


        // 栏位标题
        controller.scheduleList.isNotEmpty
            ?  TextWidget.title2(LocaleKeys.tabBarSchedul.tr)                   
                .sliverToBoxAdapter()
                .sliverPaddingHorizontal(AppSpace.page)
            : const SliverToBoxAdapter(),
        
        //排程列表
        _buildSchedules(),
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
                    )),
                onPressed: controller.onAdd,
                child: const Text('+'),
              ).sliverToBoxAdapter()
                .sliverPaddingHorizontal(AppSpace.page),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleListPageController>(
      init: ScheduleListPageController(),
      id: "schedule",
      builder: (_) {
        return Scaffold(
          body: SmartRefresher(
            controller: controller.refreshController, // 刷新控制器
            enablePullUp: true, // 启用上拉加载
            onRefresh: controller.onRefresh, // 下拉刷新回调
            //onLoading: controller.onLoading, // 上拉加载回调
            //footer: const SmartRefresherFooterWidget(), // 底部加载更多
            child: _buildView(),
          ),
        );
      },
    );
  }
}
