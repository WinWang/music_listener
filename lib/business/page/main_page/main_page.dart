import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/mine_page/mine_page.dart';
import 'package:music/business/page/netease_page/netease_page.dart';
import 'package:music/res/colors.dart';
import 'package:music/res/r.dart';
import 'package:music/route/routes.dart';
import 'package:music/utils/theme_utils.dart';

class MainPage extends BaseStatelessWidget<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        _createTabBar(),
        Expanded(
          flex: 1,
          child: TabBarView(
            controller: controller.tabController,
            children: controller.pagerList,
            // onPageChanged: (index) {
            //   controller.tabController.index = index;
            // },
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
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 80.w,
        color: ColorStyle.color_white,
      ),
      onTap: () {
        Get.toNamed(AppRoutes.musicSearchPage);
      },
    );
  }

  ///搜索按钮
  @override
  List<Widget>? appBarActionWidget(BuildContext context) {
    return [
      Container(
        padding: EdgeInsets.all(10.w),
        child: RotationTransition(
          turns: controller.animateController,
          child: Image.asset(
            R.icon_white_music,
            width: 80.w,
            height: 80.w,
          ),
        ),
      )
    ];
  }

  @override
  Widget createDrawer() {
    return Obx(() => Container(
          color: ColorStyle.color_EA4C43,
          width: 400.w,
          padding: EdgeInsets.only(left: 32.w),
          child: Column(
            children: [
              SizedBox(
                height: 200.w,
              ),
              Row(
                children: [
                  Image.asset(
                    R.icon_white_night,
                    width: 40.w,
                    height: 40.w,
                  ),
                  Text(
                    "夜间模式",
                    style: TextStyle(
                        fontSize: 32.sp, color: ColorStyle.color_white),
                  ),
                  Switch(
                      value: controller.nightMode.value,
                      onChanged: (bool open) {
                        controller.nightMode.value = open;
                        if (open) {
                          // controller.nightMode = false;
                          Get.changeTheme(Themes.black);
                        } else {
                          // controller.nightMode = true;
                          Get.changeTheme(Themes.red);
                        }
                      })
                ],
              ),
            ],
          ),
        ));
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showDrawer() => true;

  @override
  bool showBackButton() => false;
}

class MainController extends BaseController with GetTickerProviderStateMixin {
  final List<String> tabList = ["我的", "网易"];

  // final List<String> tabList = ["网易"];
  late TabController tabController =
      TabController(length: tabList.length, vsync: this);
  final PageController pagerController = PageController();
  final List<Widget> pagerList = [
    const MinePage(),
    const NeteasePage(),
  ];
  RxBool nightMode = false.obs;
  late var animateController =
      AnimationController(vsync: this, duration: const Duration(seconds: 6));

  @override
  void onReady() {
    super.onReady();
    animateController.forward();
    animateController.repeat();
    loadNet();
  }

  @override
  void loadNet() {}

  @override
  void onClose() {
    tabController.dispose();
    animateController.dispose();
    super.onClose();
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineController());
    Get.lazyPut(() => NeteaseController());
    Get.lazyPut(() => MainController());
  }
}
