import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/netease_page/widget/item_play_list_widget.dart';
import 'package:music/http/apiservice/api_service.dart';
import 'package:music/http/interceptor/netease_handler.dart';
import 'package:music/route/routes.dart';

import 'model/bean.dart';

class NeteasePage extends BaseStatelessWidget<NeteaseController> {
  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6.w, right: 6.w),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //每行三列
          childAspectRatio: 0.75, //显示区域宽高相等
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ItemPlayListWidget(controller.playList[index]),
            onTap: () {
              var id = controller.playList[index].id;
              Get.toNamed(AppRoutes.playListPage, arguments: id);
            },
          );
        },
        itemCount: controller.playList.length,
      ),
    );
  }

  @override
  bool showTitleBar() {
    return false;
  }
}

class NeteaseController extends BaseController<ApiService> {
  RxList<Play> playList = <Play>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadNet();
  }

  @override
  void loadNet() {
    httpRequest<MultiPlayListWrap>(
        api.getNeteasePlayList(options: joinOptions()), (value) {
      playList.value = value.playlists ?? [];
    });
  }
}

class NeteaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NeteaseController());
  }
}
