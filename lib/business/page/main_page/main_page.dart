import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/netease_page/netease_page.dart';
import 'package:music/res/colors.dart';
import 'package:music/route/routes.dart';

class MainPage extends BaseStatelessWidget<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _createTabBar(),
        Expanded(
          flex: 1,
          child: PageView(
            controller: controller.pagerController,
            children: controller.pagerList,
            onPageChanged: (index) {
              controller.tabController.index = index;
            },
          ),
        )
      ],
    );
  }

  /// 创建Tab
  Widget _createTabBar() {
    return Container(
      child: TabBar(
        tabs: controller.tabList
            .map((element) => Tab(
                  text: element,
                ))
            .toList(),
        labelColor: ColorStyle.color_white,
        labelStyle: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        unselectedLabelColor: ColorStyle.color_CCCCCC,
        indicatorColor: ColorStyle.color_white,
        isScrollable: false,
        controller: controller.tabController,
        indicatorWeight: 6.w,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 100.w),
        onTap: (index) {
          controller.pagerController.jumpToPage(index);
        },
      ),
      color: ColorStyle.color_EA4C43,
    );
  }

  @override
  Widget? titleWidget() {
    return Container(
      width: double.infinity,
      height: 80.w,
      color: ColorStyle.color_white,
    );
  }

  ///搜索按钮
  @override
  List<Widget>? appBarActionWidget(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.search))];
  }

  @override
  Widget createDrawer() {
    return Container(
      color: ColorStyle.color_EA4C43,
      width: 350.w,
      child: Column(
        children: [
          const Text("关于"),
          const Text("关于"),
          const Text("关于"),
          const Text("关于"),
          GestureDetector(
            child: const Text("data"),
            onTap: () {
              Get.toNamed(AppRoutes.musicDetailPage);
            },
          ),
          const Text("关于"),
        ],
      ),
    );
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showDrawer() => true;

  @override
  bool showBackButton() => false;
}

class MainController extends BaseController with GetTickerProviderStateMixin {
  final List<String> tabList = ["网易", "QQ", "酷狗"];
  late TabController tabController =
      TabController(length: tabList.length, vsync: this);
  final PageController pagerController = PageController();
  final List<Widget> pagerList = [
    NeteasePage(),
    NeteasePage(),
    NeteasePage(),
  ];

  @override
  void onReady() {
    super.onReady();
    loadNet();
  }

  @override
  void loadNet() {}
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => NeteaseController());
  }
}
