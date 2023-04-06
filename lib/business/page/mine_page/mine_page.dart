import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/mine_page/widget/item_play_my_song_list_widget.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/db/record_database.dart';

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
                controller.musicPlayerController.setCurrentMusicInfo(itemData.name ?? "", itemData.al_name ?? "",
                    itemData.picUrl ?? "", itemData.audioUrl ?? "", itemData.id);
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

class MineController extends BaseController {
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
    showToast("msg");
  }

  @override
  void loadNet() {
    queryMyRecord();
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
