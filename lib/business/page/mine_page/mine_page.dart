import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/mine_page/widget/item_play_my_song_list_widget.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/db/record_database.dart';

import '../../../http/apiservice/api_service.dart';
import '../../../http/interceptor/netease_handler.dart';
import '../../../utils/log_utils.dart';
import '../../component/music_component/music_player_component.dart';

class MinePage extends BaseStatelessWidget<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              child: ItemPlayMySongListWidget(controller.myList[index], controller.musicPlayerController.playId),
              onTap: () {
                var itemData = controller.myList[index];
                controller.getSongUrl(itemData);
              },
            );
          },
          itemCount: controller.myList.length,
        ));
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showTitleBar() => false;
}

class MineController extends BaseController<ApiService> {
  var musicPlayerController = Get.find<MusicPlayerController>();
  RxList<MyRecord> myList = <MyRecord>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadNet();
    addStremSub(eventBus.on<MyRecord>().listen((event) {
      myList.insert(0, event);
    }));
  }

  Future<void> queryMyRecord() async {
    var readAllRecord = await RecordDatabase.instance.readAllRecord();
    myList.value = readAllRecord.reversed.toList();
  }

  @override
  void loadNet() {
    queryMyRecord();
  }

  ///获取网络链接
  Future<void> getSongUrl(MyRecord itemData) async {
    httpRequest<SongUrlListWrap>(api.getSongUrlV1("[${itemData.id}]", options: joinOptions()), (value) {
      String musicUrl = value.data?[0].url ?? "";
      musicPlayerController.setCurrentMusicInfo(
          itemData.name ?? "", itemData.al_name ?? "", itemData.picUrl ?? "", musicUrl, itemData.id);
      LogWTF("网络更新播放链接2>>>>>>>>>$musicUrl");
    });
  }

  @override
  bool useEventBus() {
    return true;
  }
}

class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineController());
  }
}
