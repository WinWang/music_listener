import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keframe/keframe.dart';
import 'package:music/base/controller/base_refresh_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/netease_page/widget/item_play_list_widget.dart';
import 'package:music/http/apiservice/api_service.dart';
import 'package:music/http/interceptor/netease_handler.dart';
import 'package:music/route/routes.dart';
import 'package:music/utils/log_utils.dart';
import 'package:music/widget/pull_smart_refresher.dart';

import 'model/bean.dart';

class NeteasePage extends BaseStatelessWidget<NeteaseController> {
  const NeteasePage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return SizedBox(
      child: SizeCacheWidget(
          child: RefreshWidget<NeteaseController>(
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
      )),
    );
  }

  @override
  bool showTitleBar() {
    return false;
  }
}

class NeteaseController extends BaseRefreshController<ApiService> {
  RxList<Play> playList = <Play>[].obs;
  int offset = 0;

  @override
  void onReady() {
    super.onReady();
    loadNet();
  }

  @override
  void loadNet() {
    requestPageData();
  }

  @override
  void requestPageData({Refresh refresh = Refresh.first}) {
    if (refresh == Refresh.first || refresh == Refresh.pull) {
      offset = 0;
    }
    LogD("请求数据>>>>>>>>${offset}");
    httpRequest<MultiPlayListWrap>(
        api.getNeteasePlayList(options: joinOptions(), offset: offset),
        (value) {
      if (refresh == Refresh.first || refresh == Refresh.pull) {
        playList.clear();
      }
      playList.addAll(value.playlists ?? []);
      if (playList.value.isNotEmpty) {
        offset = playList.length;
      }
      if (playList.length >= (value.total ?? 0)) {
        hideRefresh(refreshController, finishLoadMore: true);
      } else {
        hideRefresh(refreshController, finishLoadMore: false);
      }
    });
  }
}

class NeteaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NeteaseController());
  }
}
